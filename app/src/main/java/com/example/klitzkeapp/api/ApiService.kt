package com.example.klitzkeapp.api

import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.POST
import com.example.klitzkeapp.models.loginRequest
import com.example.klitzkeapp.models.loginResponse

interface ApiService {
    @POST("login")
    fun loginUser(@Body loginRequest: loginRequest): Call<loginResponse>
}