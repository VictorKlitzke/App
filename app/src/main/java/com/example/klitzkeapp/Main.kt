package com.example.klitzkeapp

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.klitzkeapp.ui.login
import com.example.klitzkeapp.ui.themes.KlitzkeAppTheme

class Main: ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            KlitzkeAppTheme {

                val navController = rememberNavController();
                NavHost(navController = navController, startDestination = "login") {
                    composable(
                        route = "login"
                    ) {
                        login(navController);
                    }
                }
                
            }
        }
    }
}