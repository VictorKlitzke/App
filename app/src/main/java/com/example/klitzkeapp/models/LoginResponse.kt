package com.example.klitzkeapp.models

data class loginResponse(
    val success: Boolean,
    val token: String?,
    val message: String?,
)
