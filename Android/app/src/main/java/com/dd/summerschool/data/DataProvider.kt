package com.dd.summerschool.data

import android.content.res.AssetManager
import androidx.annotation.WorkerThread
import com.dd.summerschool.model.University
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import java.io.InputStreamReader


object DataProvider {

    private const val UNIVERSITIES_JSON = "universities.json"

    @WorkerThread
    fun load(asset: AssetManager): List<University>? {
        val streamReader = InputStreamReader(asset.open(UNIVERSITIES_JSON))
        val listType = object : TypeToken<ArrayList<University?>?>() {}.type
        return Gson().fromJson(streamReader, listType)
    }
}