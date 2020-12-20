package com.xuning.native_font_example;


import android.graphics.fonts.FontStyle;
import android.os.Handler;
import android.os.Looper;

import com.xuning.native_font.NativeFontPlugin;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.util.Timer;
import java.util.TimerTask;

import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        configNativeFontForFlutter();
    }

    private void configNativeFontForFlutter() {
        NativeFontPlugin.setFontDataHandler((familyName, fontWeight, isItalic, fontCallBack) -> {
            if (familyName.equals("Roboto")) {
                int familyId = R.font.roboto_regular;
                if (fontWeight == FontStyle.FONT_WEIGHT_BOLD) { //700
                    familyId = isItalic ? R.font.roboto_bold_italic : R.font.roboto_bold;
                } else if (fontWeight == FontStyle.FONT_WEIGHT_NORMAL) {
                    familyId = isItalic ? R.font.roboto_italic : R.font.roboto_regular;
                } else if (fontWeight == FontStyle.FONT_WEIGHT_MEDIUM) {
                    familyId = R.font.roboto_medium;
                }
                fontCallBack.onFontLoadCompleted(fontResToByteBuffer(familyId));
            } else if (familyName.equals("Caveat")) {
                // Mock download
                new Timer().schedule(new TimerTask() {
                    @Override
                    public void run() {
                        new Handler(Looper.getMainLooper()).post(new Runnable() {
                            @Override
                            public void run() {
                                fontCallBack.onFontLoadCompleted(fontResToByteBuffer(R.font.caveat_regular));
                            }
                        });
                        this.cancel();
                    }
                }, 3000);
            }
        });
    }

    private ByteBuffer fontResToByteBuffer(int fontId) {
        InputStream inputStream = getResources().openRawResource(fontId);
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        byte[] buffer = new byte[4096];
        int n = 0;
        while (true) {
            try {
                if (-1 == (n = inputStream.read(buffer))) {
                    inputStream.close();
                    output.close();
                    break;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            output.write(buffer, 0, n);
        }
        ByteBuffer byteBuffer = ByteBuffer.allocateDirect(output.toByteArray().length);
        byteBuffer.put(output.toByteArray());
        return byteBuffer;
    }
}
