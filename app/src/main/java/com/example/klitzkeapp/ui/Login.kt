package com.example.klitzkeapp.ui

import android.os.Bundle
import android.view.LayoutInflater
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalContext
import androidx.navigation.NavController
import com.example.klitzkeapp.api.RetrofitInstance
import com.example.klitzkeapp.databinding.LoginBinding
import com.example.klitzkeapp.models.loginRequest
import com.example.klitzkeapp.models.loginResponse
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

@Composable
fun login(navController: NavController) {
    val binding = LoginBinding.inflate(LayoutInflater.from(LocalContext.current))

    binding.loginButton.setOnClickListener {
        val username = binding.username.text.toString()
        val password = binding.password.text.toString()

        if (username.isEmpty() || password.isEmpty()) {
            Toast.makeText(LocalContext.current, "Preencha os campos", Toast.LENGTH_SHORT).show()
        }

        val loginRequest = loginRequest(username, password)
        RetrofitInstance.api.loginUser(loginRequest).enqueue(object : Callback<loginResponse> {
            override fun onResponse(call: Call<loginResponse>, response: Response<loginResponse>) {
                if (response.isSuccessful) {
                    val loginResponse = response.body()
                    if (loginResponse?.success == true) {
                        Toast.makeText(LocalContext.current, "Login bem-sucedido!", Toast.LENGTH_SHORT).show()
                        // Navegar para outra tela
                        navController.navigate("next_screen") // Substitua "next_screen" pelo destino que você deseja navegar
                    } else {
                        Toast.makeText(LocalContext.current, loginResponse?.message ?: "Erro", Toast.LENGTH_SHORT).show()
                    }
                } else {
                    Toast.makeText(LocalContext.current, "Erro de resposta!", Toast.LENGTH_SHORT).show()
                }
            }

            override fun onFailure(call: Call<loginResponse>, t: Throwable) {
                Toast.makeText(LocalContext.current, "Erro de rede!", Toast.LENGTH_SHORT).show()
            }
        })
    }
}
