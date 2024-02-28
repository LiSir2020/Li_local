package cn.edu.fudan.analysis;

import org.jf.dexlib2.Opcode;
import org.jf.dexlib2.dexbacked.instruction.*;
import org.jf.dexlib2.iface.*;
import org.jf.dexlib2.iface.instruction.Instruction;
import org.jf.dexlib2.iface.instruction.SwitchElement;

import java.sql.Array;
import java.util.*;


public class CFG {

    /**
     * The method that the control flow graph is built on
     */
    private Method targetMethod = null;

    /**
     * All the basic blocks EXCEPT catch blocks.
     */
    private HashSet<BasicBlock> blocks = new HashSet<BasicBlock>();

    /**
     * Entry block of this method
     * */
    private BasicBlock entryBB;

    private CFG(){}

    public static String classType2Name(String s) {
        if (s == null) return "";

        if (s.startsWith("L"))
            s = s.substring(1);

        String res = s.replace(";", "").replace("$", "~").replace("/",".");
        return res;
    }

    public static String methodSignature2Name(Method m) {
        String temp = m.getName() + "(";
        List<? extends CharSequence> parameters = m.getParameterTypes();
        List<String> params = new ArrayList<>();
        for (CharSequence p : parameters) {
            String param = p.toString();
            String suffix = "";
            if (param.startsWith("["))
            {
                suffix = "[]";
                param = param.substring(1);
            }
            switch (param)
            {
                case "B":
                    params.add("byte" + suffix);
                    break;
                case "C":
                    params.add("char" + suffix);
                    break;
                case "D":
                    params.add("double" + suffix);
                    break;
                case "F":
                    params.add("float" + suffix);
                    break;
                case "I":
                    params.add("int" + suffix);
                    break;
                case "J":
                    params.add("long" + suffix);
                    break;
                case "S":
                    params.add("short" + suffix);
                    break;
                case "V":
                    params.add("void" + suffix);
                    break;
                case "Z":
                    params.add("boolean" + suffix);
                    break;
                default:
                    String tmp = classType2Name(param);

                    if (tmp.contains("~"))
                        tmp = tmp.substring(tmp.lastIndexOf('~') + 1);

                    params.add(tmp + suffix);
                    break;
            }
        }

        temp += String.join(",", params);
        temp += ")";
        return temp;
    }

    public static CFG createCFG(Method method) {
        CFG cfg = new CFG();
        cfg.targetMethod = method;

        Iterable<? extends Instruction> instructions = cfg.targetMethod.getImplementation().getInstructions();

        int flag = 0;
        BasicBlock presentBlock = null;
        BasicBlock preBlock = null;
        BasicBlock lastBlock = null;
        int whatfuck = 0;
        int nexfuc = 0;
        Queue<BasicBlock> Block = new ArrayDeque();
        Queue Instr = new ArrayDeque();
        List address = new ArrayList<>();

        for (Instruction i1 : instructions){
            DexBackedInstruction dbi = (DexBackedInstruction) i1;
            if(flag == 0){
                address.add(dbi.instructionStart);
                flag = 1;
            }
            int offset;
            switch (dbi.opcode) {
                case GOTO:
                    offset = ((DexBackedInstruction10t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                    System.out.println(dbi.getOpcode() + ", offset: " + offset);
                    address.add(offset);
                    break;
                case GOTO_16:
                    offset = ((DexBackedInstruction20t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                    System.out.println(dbi.getOpcode() + ", offset: " + offset);
                    address.add(offset);
                    break;
                case GOTO_32:
                    offset = ((DexBackedInstruction30t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                    System.out.println(dbi.getOpcode() + ", offset: " + offset);
                    address.add(offset);
                    break;
                case IF_EQ:
                case IF_NE:
                case IF_LT:
                case IF_GE:
                case IF_GT:
                case IF_LE:
                    offset = dbi.instructionStart + dbi.getOpcode().format.size;
                    System.out.println(dbi.getOpcode() + ", offset1: " + offset);
                    address.add(offset);

                    offset = ((DexBackedInstruction22t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                    System.out.println(dbi.getOpcode() + ", offset2: " + offset);
                    address.add(offset);
                    break;
                case IF_EQZ:
                case IF_NEZ:
                case IF_LTZ:
                case IF_GEZ:
                case IF_GTZ:
                case IF_LEZ:
                    offset = dbi.instructionStart + dbi.getOpcode().format.size;
                    System.out.println(dbi.getOpcode() + ", offset1: " + offset);
                    address.add(offset);

                    offset = ((DexBackedInstruction21t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                    System.out.println(dbi.getOpcode() + ", offset2: " + offset);
                    address.add(offset);
                    break;

                case PACKED_SWITCH:
                case SPARSE_SWITCH:
                    offset = ((DexBackedInstruction31t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                    System.out.println(dbi.getOpcode() + ", switch payload offset: " + offset);
                    address.add(offset);
                    whatfuck = 1;
                    Instr.add(dbi.instructionStart);
                    break;

                case PACKED_SWITCH_PAYLOAD:
                case SPARSE_SWITCH_PAYLOAD:
                    // Since switch-payloads actually are just data, not an instruction.
                    // Though dexlib treat them as special instructions
                    // (sparse-switch-payload & packed-switch-payload),
                    // we should not include them in our CFG.

                    // Take the following switch instruction for example.
                    // 0xAA switch : switch_payload_0
                    // ...
                    // 0xBB switch_payload_0:
                    // 0x1-> 20(offset)
                    // 0x6-> 50(offset)
                    // The offset in a payload instruction points to the instruction
                    // whose address is relative to the address of the switch opcode(0xAA),
                    // not of this table(0xBB).
                    List<? extends SwitchElement> switchElements = null;
                    if (dbi instanceof DexBackedPackedSwitchPayload)
                        switchElements = ((DexBackedPackedSwitchPayload) dbi).getSwitchElements();
                    else
                        switchElements = ((DexBackedSparseSwitchPayload) dbi).getSwitchElements();
                    int dd = (int) Instr.poll();
                    for (SwitchElement s : switchElements) {
                        /*
                         * !!! Important:
                         * According to sparse-switch-payload Format :
                         * The targets are relative to the address of the switch opcode, not of this table.
                         */
                        address.add(dd + s.getOffset()*2);
                        System.out.println(dbi.getOpcode() + ", offset: " + s.getOffset());
                    }
                    break;
                case MOVE_EXCEPTION: address.add(dbi.instructionStart);break;

                default:
                    if(whatfuck == 1){
                        address.add(dbi.instructionStart);
                        nexfuc = dbi.instructionStart;
                        whatfuck = 0;
                    }
                    break;
            }

        }

        BasicBlock basicBlock = cfg.entryBB;
        for (Instruction i0 : instructions){
            DexBackedInstruction dbi = (DexBackedInstruction) i0;
            int fla = 0;
            if (address.contains(dbi.instructionStart) && fla == 0){
                basicBlock = new  BasicBlock(method, dbi.instructionStart);
                basicBlock.addInstruction(dbi);
                cfg.entryBB = basicBlock;
                cfg.blocks.add(basicBlock);
                fla = 1;
            }
            if(fla == 0){
                basicBlock.addInstruction(dbi);
            }
        }

        int count = 0;
        flag = 0;

        System.out.println("fuc:"+ address.size());
        for(int p=0; p<address.size(); p++){
            System.out.println("fu:"+ address.get(p));
        }

        for(Instruction i2 : instructions){
            DexBackedInstruction dbi = (DexBackedInstruction) i2;
            if(address.contains(dbi.instructionStart)) {
                for (BasicBlock bb : cfg.blocks) {
                    if (bb.getStartAddress() == dbi.instructionStart) {
                        preBlock = bb;
                        if (flag == 0) {
                            flag = 1;
                        } else {
                            if (count == 0) {
                                lastBlock.addSuccessor(preBlock);
                            }
                        }
                        lastBlock = preBlock;
                    }
                }
            }
                        int offset;
                        switch (dbi.opcode) {
                            case GOTO:
                                count = 1;
                                offset = ((DexBackedInstruction10t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                                System.out.println(dbi.getOpcode() + ", offset: " + offset);
                                linkBlock(cfg, preBlock, offset);
                                break;
                            case GOTO_16:
                                count = 1;
                                offset = ((DexBackedInstruction20t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                                System.out.println(dbi.getOpcode() + ", offset: " + offset);
                                linkBlock(cfg, preBlock, offset);
                                break;
                            case GOTO_32:
                                count = 1;
                                offset = ((DexBackedInstruction30t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                                System.out.println(dbi.getOpcode() + ", offset: " + offset);
                                linkBlock(cfg, preBlock, offset);
                                break;
                            case IF_EQ:
                            case IF_NE:
                            case IF_LT:
                            case IF_GE:
                            case IF_GT:
                            case IF_LE:
                                count = 1;
                                offset = dbi.instructionStart + dbi.getOpcode().format.size;
                                System.out.println(dbi.getOpcode() + ", offset1: " + offset);
                                linkBlock(cfg, preBlock, offset);

                                offset = ((DexBackedInstruction22t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                                System.out.println(dbi.getOpcode() + ", offset2: " + offset);
                                linkBlock(cfg, preBlock, offset);
                                break;
                            case IF_EQZ:
                            case IF_NEZ:
                            case IF_LTZ:
                            case IF_GEZ:
                            case IF_GTZ:
                            case IF_LEZ:
                                count = 1;
                                offset = dbi.instructionStart + dbi.getOpcode().format.size;
                                System.out.println(dbi.getOpcode() + ", offset1: " + offset);
                                linkBlock(cfg, preBlock, offset);

                                offset = ((DexBackedInstruction21t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                                System.out.println(dbi.getOpcode() + ", offset2: " + offset);
                                linkBlock(cfg, preBlock, offset);
                                break;

                            case PACKED_SWITCH:
                            case SPARSE_SWITCH:
                                count= 1;
                                offset = ((DexBackedInstruction31t) dbi).getCodeOffset() * 2 + dbi.instructionStart;
                                System.out.println(dbi.getOpcode() + ", switch payload offset: " + offset);
                                Block.add(preBlock);
                                linkBlock(cfg, preBlock, nexfuc);
                                Instr.add(dbi.instructionStart);
                                break;

                            case PACKED_SWITCH_PAYLOAD:
                            case SPARSE_SWITCH_PAYLOAD:
                                // Since switch-payloads actually are just data, not an instruction.
                                // Though dexlib treat them as special instructions
                                // (sparse-switch-payload & packed-switch-payload),
                                // we should not include them in our CFG.

                                // Take the following switch instruction for example.
                                // 0xAA switch : switch_payload_0
                                // ...
                                // 0xBB switch_payload_0:
                                // 0x1-> 20(offset)
                                // 0x6-> 50(offset)
                                // The offset in a payload instruction points to the instruction
                                // whose address is relative to the address of the switch opcode(0xAA),
                                // not of this table(0xBB).
                                List<? extends SwitchElement> switchElements = null;
                                if (dbi instanceof DexBackedPackedSwitchPayload)
                                    switchElements = ((DexBackedPackedSwitchPayload) dbi).getSwitchElements();
                                else
                                    switchElements = ((DexBackedSparseSwitchPayload) dbi).getSwitchElements();

                                BasicBlock father = Block.poll();
                                int ins = (int) Instr.poll();
                                for (SwitchElement s : switchElements) {
                                    /*
                                     * !!! Important:
                                     * According to sparse-switch-payload Format :
                                     * The targets are relative to the address of the switch opcode, not of this table.
                                     */
                                    linkBlock(cfg, father, ins + s.getOffset()*2);
                                    System.out.println(dbi.getOpcode() + ", offset: " + s.getOffset());
                                }
                                break;
                            case RETURN: count = 1;break;
                            case THROW: count = 1; break;
                            case RETURN_OBJECT: count = 1; break;

                            default:
                                count = 0;
                        }

        }


        return cfg;
    }

    /**
     * link an edge from BasicBlock (bb) to a BasicBlock started at offset
     * */
    private static void linkBlock(CFG cfg, BasicBlock bb, int offset) {
        for (BasicBlock basicBlock : cfg.blocks) {
            if (basicBlock.getStartAddress() == offset) {
                bb.addSuccessor(basicBlock);
                return;
            }
        }
        // Typically, no exception will be thrown.
        throw new RuntimeException("no basic block found at offset: " + offset);
    }

    public BasicBlock getEntryBB() {return entryBB;}

    public Method getTargetMethod(){
        return this.targetMethod;
    }

    public HashSet<BasicBlock> getBasicBlocks() {
        return blocks;
    }
}
