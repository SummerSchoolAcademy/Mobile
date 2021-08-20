package com.dd.summerschool.model

data class University(
    val id: String,
    val name: String,
    val city: String,
    val description: String,
    val year: Int,
    val image: String,
    @Transient
    var favourite: Boolean = false
)
