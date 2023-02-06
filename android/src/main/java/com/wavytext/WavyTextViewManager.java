package com.wavytext;

import android.graphics.Color;

import androidx.annotation.Nullable;

import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.ViewManagerDelegate;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.viewmanagers.WavyTextViewManagerDelegate;
import com.facebook.react.viewmanagers.WavyTextViewManagerInterface;

@ReactModule(name = WavyTextViewManager.NAME)
public class WavyTextViewManager extends SimpleViewManager<WavyTextView> implements WavyTextViewManagerInterface<WavyTextView> {

  public static final String NAME = "WavyTextView";

  private final ViewManagerDelegate<WavyTextView> mDelegate;

  public WavyTextViewManager() {
    mDelegate = new WavyTextViewManagerDelegate(this);
  }

  @Nullable
  @Override
  protected ViewManagerDelegate<WavyTextView> getDelegate() {
    return mDelegate;
  }

  @Override
  public String getName() {
    return NAME;
  }

  @Override
  public WavyTextView createViewInstance(ThemedReactContext context) {
    return new WavyTextView(context);
  }

  @Override
  @ReactProp(name = "color")
  public void setColor(WavyTextView view, String color) {
    view.setBackgroundColor(Color.parseColor(color));
  }
}
