package com.dd.summerschool.ui.list

interface UniversityItemListener {
    fun onItemFavourite(itemId: String, on: Boolean)
    fun onItemTap(itemId: String)
}