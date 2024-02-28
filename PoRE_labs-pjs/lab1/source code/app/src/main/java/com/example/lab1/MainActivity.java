package com.example.lab1;

import androidx.appcompat.app.AppCompatActivity;

import android.content.BroadcastReceiver;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Intent;
import android.content.IntentFilter;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.view.View.OnClickListener;

import jdk.vm.ci.meta.Constant;

public class MainActivity extends AppCompatActivity implements View.OnClickListener{
    private ContentResolver mContentResolver = null;
    private Cursor cursor = null;

    @Override
    //1个地方
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button startBtn = (Button)this.findViewById(R.id.button1);  // id:button1
        Button stopBtn = (Button)this.findViewById(R.id.button2);  // id:button2
        Button statBtn = (Button)this.findViewById(R.id.button3);  // id:button3
        Button dynaBtn = (Button)this.findViewById(R.id.button4);  // id:button4
        Button testBtn = (Button)this.findViewById(R.id.button5);  // id:button5
        startBtn.setOnClickListener(this);
        stopBtn.setOnClickListener(this);
        statBtn.setOnClickListener(this);
        dynaBtn.setOnClickListener(this);
        testBtn.setOnClickListener(this);
        MyClass1 br = new MyClass1();
        IntentFilter intentFilter = new IntentFilter("com.android.skill");
        intentFilter.addAction("android.intent.action.MY_BROADCAST");
        this.registerReceiver(br, intentFilter);
        TextView tv = (TextView)this.findViewById(R.id.textView);  // id:textView
        this.mContentResolver = this.getContentResolver();
        tv.setText("Add initial data ");
        int i;
        for(i = 0; i < 10; ++i) {
            ContentValues values = new ContentValues();
            values.put("name", "haha" + i);
            this.mContentResolver.insert(Constant.CONTENT_URI, values);
    }

    @Override
    //2个地方
    public void onClick(View v) {
        if (v != null) {
            switch(v.getId()) {
                case R.id.button1: {  // id:button1
                    this.startService(new Intent(this, MyClass2.class));
                    return;
                }
                case R.id.button2: {  // id:button2
                    this.stopService(new Intent(this, MyClass2.class));
                    return;
                }
                case R.id.button3: {  // id:button3
                    Intent custIntent = new Intent();
                    custIntent.setAction("com.exmaple.CUSTOM_INTENT");
                    custIntent.setPackage("com.example.myapplication");
                    this.sendBroadcast(custIntent);
                }
                case R.id.button4: {  // id:button4
                    this.sendBroadcast(new Intent("android.intent.action.MY_BROADCAST"));
                }
                case R.id.button5: {  // id:button5
                    TextView tv = (TextView)this.findViewById(R.id.textView);  // id:textView
                    tv.setText("Query Data ");
                    Cursor v1 = this.mContentResolver.query(Constant.CONTENT_URI, new String[]{"_id", "name"}, null, null, null);
                    this.cursor = v1;
                    if(v1.moveToFirst()) {
                        tv.setText("The first data： " + this.cursor.getString(this.cursor.getColumnIndex("name")));
                        return;
                    }

                    return;
                }
                default: {
                    return;
                }
            }
        }
    }

}