# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.25

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = C:\mingw64\bin\cmake.exe

# The command to remove a file.
RM = C:\mingw64\bin\cmake.exe -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = E:\0Tree_Down\crypto\0last2\SM3

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = E:\0Tree_Down\crypto\0last2\SM3\build

# Include any dependencies generated for this target.
include CMakeFiles/SM3.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/SM3.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/SM3.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/SM3.dir/flags.make

CMakeFiles/SM3.dir/Smain.cpp.obj: CMakeFiles/SM3.dir/flags.make
CMakeFiles/SM3.dir/Smain.cpp.obj: E:/0Tree_Down/crypto/0last2/SM3/Smain.cpp
CMakeFiles/SM3.dir/Smain.cpp.obj: CMakeFiles/SM3.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=E:\0Tree_Down\crypto\0last2\SM3\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/SM3.dir/Smain.cpp.obj"
	C:\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/SM3.dir/Smain.cpp.obj -MF CMakeFiles\SM3.dir\Smain.cpp.obj.d -o CMakeFiles\SM3.dir\Smain.cpp.obj -c E:\0Tree_Down\crypto\0last2\SM3\Smain.cpp

CMakeFiles/SM3.dir/Smain.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/SM3.dir/Smain.cpp.i"
	C:\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E E:\0Tree_Down\crypto\0last2\SM3\Smain.cpp > CMakeFiles\SM3.dir\Smain.cpp.i

CMakeFiles/SM3.dir/Smain.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/SM3.dir/Smain.cpp.s"
	C:\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S E:\0Tree_Down\crypto\0last2\SM3\Smain.cpp -o CMakeFiles\SM3.dir\Smain.cpp.s

CMakeFiles/SM3.dir/SM3.cpp.obj: CMakeFiles/SM3.dir/flags.make
CMakeFiles/SM3.dir/SM3.cpp.obj: E:/0Tree_Down/crypto/0last2/SM3/SM3.cpp
CMakeFiles/SM3.dir/SM3.cpp.obj: CMakeFiles/SM3.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=E:\0Tree_Down\crypto\0last2\SM3\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/SM3.dir/SM3.cpp.obj"
	C:\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/SM3.dir/SM3.cpp.obj -MF CMakeFiles\SM3.dir\SM3.cpp.obj.d -o CMakeFiles\SM3.dir\SM3.cpp.obj -c E:\0Tree_Down\crypto\0last2\SM3\SM3.cpp

CMakeFiles/SM3.dir/SM3.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/SM3.dir/SM3.cpp.i"
	C:\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E E:\0Tree_Down\crypto\0last2\SM3\SM3.cpp > CMakeFiles\SM3.dir\SM3.cpp.i

CMakeFiles/SM3.dir/SM3.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/SM3.dir/SM3.cpp.s"
	C:\mingw64\bin\g++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S E:\0Tree_Down\crypto\0last2\SM3\SM3.cpp -o CMakeFiles\SM3.dir\SM3.cpp.s

# Object files for target SM3
SM3_OBJECTS = \
"CMakeFiles/SM3.dir/Smain.cpp.obj" \
"CMakeFiles/SM3.dir/SM3.cpp.obj"

# External object files for target SM3
SM3_EXTERNAL_OBJECTS =

E:/0Tree_Down/crypto/0last2/SM3/SM3.exe: CMakeFiles/SM3.dir/Smain.cpp.obj
E:/0Tree_Down/crypto/0last2/SM3/SM3.exe: CMakeFiles/SM3.dir/SM3.cpp.obj
E:/0Tree_Down/crypto/0last2/SM3/SM3.exe: CMakeFiles/SM3.dir/build.make
E:/0Tree_Down/crypto/0last2/SM3/SM3.exe: CMakeFiles/SM3.dir/linkLibs.rsp
E:/0Tree_Down/crypto/0last2/SM3/SM3.exe: CMakeFiles/SM3.dir/objects1
E:/0Tree_Down/crypto/0last2/SM3/SM3.exe: CMakeFiles/SM3.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=E:\0Tree_Down\crypto\0last2\SM3\build\CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable E:\0Tree_Down\crypto\0last2\SM3\SM3.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\SM3.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/SM3.dir/build: E:/0Tree_Down/crypto/0last2/SM3/SM3.exe
.PHONY : CMakeFiles/SM3.dir/build

CMakeFiles/SM3.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles\SM3.dir\cmake_clean.cmake
.PHONY : CMakeFiles/SM3.dir/clean

CMakeFiles/SM3.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" E:\0Tree_Down\crypto\0last2\SM3 E:\0Tree_Down\crypto\0last2\SM3 E:\0Tree_Down\crypto\0last2\SM3\build E:\0Tree_Down\crypto\0last2\SM3\build E:\0Tree_Down\crypto\0last2\SM3\build\CMakeFiles\SM3.dir\DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/SM3.dir/depend

