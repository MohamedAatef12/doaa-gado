import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("app")

    productFlavors {
        create("dev") {
            dimension = "app"
            applicationId = "com.example.doaa_gado.dev"
            resValue(type = "string", name = "app_name", value = "Doaa Gado Dev")
        }
        create("prod") {
            dimension = "app"
            applicationId = "com.example.doaa_gado"
            resValue(type = "string", name = "app_name", value = "Doaa Gado")
        }
    }
}