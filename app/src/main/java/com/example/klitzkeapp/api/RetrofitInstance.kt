package com.example.klitzkeapp.api

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import com.example.klitzkeapp.api.ApiService


object RetrofitInstance {
    private val BASE_URL = "";
    val api: ApiService by lazy {
        Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
    }
}