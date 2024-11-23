package com.example.klitzkeapp

import android.os.Bundle;
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity;
import com.example.klitzkeapp.databinding.LoginBinding

class login : AppCompatActivity() {

    private lateinit var binding: LoginBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = LoginBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.login.setOnClickListener {
            val email = binding.email.toString()
            val password = binding.passwordInput.toString()

            if (email.isEmpty() || password.isEmpty()) {
                Toast.makeText(this, "Preencha os campos", Toast.LENGTH_SHORT).show();
            }

        }
    }
}
