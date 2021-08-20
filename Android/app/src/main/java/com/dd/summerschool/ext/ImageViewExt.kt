package com.dd.summerschool.ext

import android.graphics.drawable.Drawable
import android.widget.ImageView
import java.io.IOException
import java.io.InputStream

fun ImageView.setImageFromAsset(uri: String) {
    try {
        val ims: InputStream = this.resources.assets.open(uri)
        val drawable = Drawable.createFromStream(ims, null)
        this.setImageDrawable(drawable)
        ims.close()
    }
    catch (ex: IOException) {
        return
    }
}