package com.dd.summerschool.data

import android.content.res.AssetManager
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.dd.summerschool.model.University

object UniversitiesRepository {

    private var isFilterOn: Boolean = false
    private val universities: MutableList<University> = mutableListOf()
    private val universitiesLiveData: MutableLiveData<List<University>> = MutableLiveData()

    fun loadData(assetManager: AssetManager) {
        val data = DataProvider.load(assetManager)
        if (data != null && universities.isEmpty()) {
            universities.addAll(data)
            universitiesLiveData.postValue(data)
        }
    }

    fun updateFavourite(itemId: String, on: Boolean) {
        for (uni in universities) {
            if (uni.id == itemId)
                uni.favourite = on
        }
        notifyObserver()
    }

    fun toggleFilter() {
        isFilterOn = !isFilterOn
        notifyObserver()
    }

    fun observeData(lifecycleOwner: LifecycleOwner, observer: Observer<List<University>>) {
        universitiesLiveData.observe(lifecycleOwner, observer)
    }

    fun clearData() {
        universities.clear()
    }

    private fun notifyObserver() {
        if (isFilterOn) {
            universitiesLiveData.value = universities.filter { it.favourite }
        } else {
            universitiesLiveData.value = universities
        }
    }

    fun getById(itemId: String): University {
        return universities.find { it.id == itemId } ?: universities.first()
    }
}