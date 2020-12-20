package com.xuning.native_font;


import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import org.json.JSONException;
import org.json.JSONObject;

import java.nio.ByteBuffer;
import java.nio.charset.Charset;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryCodec;

public class NativeFontPlugin implements FlutterPlugin, BasicMessageChannel.MessageHandler<ByteBuffer> {
    private BasicMessageChannel<ByteBuffer> basicMessageChannel;
    private static FontDataHandler fontDataHandler;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        basicMessageChannel = new BasicMessageChannel<>(
                flutterPluginBinding.getBinaryMessenger(),
                "com.xuning.native_font", BinaryCodec.INSTANCE);
        basicMessageChannel.setMessageHandler(this);
    }

    public static void setFontDataHandler(FontDataHandler fontDataHandler) {
        NativeFontPlugin.fontDataHandler = fontDataHandler;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        basicMessageChannel.setMessageHandler(null);
    }


    @Override
    public void onMessage(@Nullable ByteBuffer message, @NonNull BasicMessageChannel.Reply<ByteBuffer> reply) {
        try {
            JSONObject jsonObject = new JSONObject(Charset.forName("utf-8").decode(message).toString());
            fontPathHandler(jsonObject, reply);
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    private void fontPathHandler(JSONObject jsonObject, final BasicMessageChannel.Reply<ByteBuffer> reply) throws JSONException {
        String familyName = (String) jsonObject.get("familyName");
        int fontWeight = (int) jsonObject.get("weight");
        boolean isItalic = (boolean) jsonObject.get("isItalic");
        if (fontDataHandler != null) {
            fontDataHandler.getFontByteBuffer(familyName, fontWeight, isItalic, new FontCallBack() {
                @Override
                public void onFontLoadCompleted(ByteBuffer byteBuffer) {
                    reply.reply(byteBuffer);
                }
            });
        }
    }

    public interface FontDataHandler {
        void getFontByteBuffer(String familyName, int fontWeight, boolean isItalic, FontCallBack fontCallBack);
    }

    public interface FontCallBack {
        void onFontLoadCompleted(ByteBuffer byteBuffer);
    }
}
