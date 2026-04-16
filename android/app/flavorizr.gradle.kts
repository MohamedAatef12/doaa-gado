import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("app")

    productFlavors {
        create("development") {
            dimension = "app"
            applicationId = "com.example.doaa_gado.dev"
            resValue(type = "string", name = "app_name", value = "Doaa Gado Dev")
        }
        create("production") {
            dimension = "app"
            applicationId = "com.example.doaa_gado"
            resValue(type = "string", name = "app_name", value = "Doaa Gado")
        }
    }
}