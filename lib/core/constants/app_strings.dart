// lib
// ├── main
// │   ├── main_common.dart
// │   ├── main_development.dart
// │   ├── main_production.dart
// │   └── my_app.dart
// ├── core
// │   ├── assets
// │   │   ├── fonts.dart
// │   │   ├── icons.dart
// │   │   └── images.dart
// │   ├── constants
// │   │   ├── api_endpoints.dart
// │   │   ├── app_keys.dart
// │   │   ├── app_strings.dart
// │   │   ├── icons.dart
// │   │   ├── padding.dart
// │   │   ├── radius.dart
// │   │   ├── sized_box.dart
// │   │   └── text_styles.dart
// │   ├── error
// │   │   ├── custom_exceptions.dart
// │   │   ├── error_handler.dart
// │   │   ├── error_messages.dart
// │   │   └── failure.dart
// │   ├── locale
// │   │   ├── en.dart
// │   │   └── er.dart
// │   ├── themes
// │   │   ├── app_colors.dart
// │   │   ├── app_theme.dart
// │   │   ├── dark_theme.dart
// │   │   └── light_theme.dart
// │   └── utils
// │       ├── custom_button.dart
// │       ├── custom_text_form_field.dart
// │       ├── date_formatter.dart
// │       ├── logger.dart
// │       └── validators.dart
// ├── config
// │   ├── di
// │   │   ├── di.config.dart
// │   │   └── di.dart
// │   ├── env
// │   │   ├── .env
// │   │   ├── app_config.dart
// │   │   ├── env.dart
// │   │   └── env.g.dart
// │   └── router
// │       ├── app_router.dart
// │       ├── guards.dart
// │       └── routes.dart
// ├── data
// │   ├── caching
// │   │   ├── secure_storage_helper.dart
// │   │   └── shared_prefs_helper.dart
// │   └── network
// │       ├── api_services.dart
// │       ├── dio_factory.dart
// │       ├── interceptors.dart
// │       └── network_info.dart
// ├── features
// │   ├── auth
// │   │   ├── data
// │   │   │   ├── models
// │   │   │   │   ├── login_model.dart
// │   │   │   │   └── user_model.dart
// │   │   │   ├── repos
// │   │   │   │   └── auth_repository_impl.dart              #Entity
// │   │   │   └── sources
// │   │   │       ├── local
// │   │   │       │   └── auth_local_datasource.dart
// │   │   │       └── remote
// │   │   │           └── auth_remote_datasource.dart        #Model
// │   │   ├── domain
// │   │   │   ├── entities
// │   │   │   │   ├── login_entity.dart
// │   │   │   │   └── user_entity.dart
// │   │   │   ├── repositories
// │   │   │   │   └── auth_repository.dart                   #Entity
// │   │   │   └── usecases
// │   │   │       ├── login_user.dart                        #Entity
// │   │   │       └── sign_up.dart                           #Entity
// │   │   └── presentation
// │   │       ├── blocs
// │   │       │   ├── auth_bloc.dart                         #Events
// │   │       │   ├── auth_event.dart                        #Entity
// │   │       │   └── auth_state.dart                        #Entity
// │   │       ├── pages
// │   │       │   ├── login_page.dart
// │   │       │   └── register_page.dart
// │   │       └── widgets
// │   │           └── login_form.dart
// │   └── home
// │       ├── data
// │       │   ├── models
// │       │   │   └── home_model.dart
// │       │   ├── repositories_impl
// │       │   │   └── post_repository_impl.dart
// │       │   └── sources
// │       │       ├── local
// │       │       │   └── home_local_datasource.dart
// │       │       └── remote
// │       │           └── post_remote_datasource.dart
// │       ├── domain
// │       │   ├── entities
// │       │   │   └── home_entity.dart
// │       │   ├── repositories
// │       │   │   └── home_repository.dart
// │       │   └── usecases
// │       │       └── fetch_posts.dart
// │       └── presentation
// │           ├── blocs
// │           │   ├── favorite_bloc.dart
// │           │   ├── favorite_event.dart
// │           │   └── favorite_state.dart
// │           ├── pages
// │           │   └── favorite_page.dart
// │           └── widgets
// │               └── post_card.dart
// └── assets
// ├── fonts
// │   └── font
// ├── icons
// │   └── icon
// ├── images
// │   └── image
// └── translations
// ├── ar
// └── en
//
