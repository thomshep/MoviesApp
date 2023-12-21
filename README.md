# MoviesAPP

Aplicación iOS desarrollada en SwiftUI para mostrar un listado de películas y el detalle de cada una.

## Capturas

## Requisitos previos
Xcode 15

## Dependencias
SwiftRealm (usando Swift Package Manager)

## Características
- Patrón ViewModel. La vista se encarga solo de mostrar información, el ViewModel de llamar a la API, ordenarla y persistirla.
- Router que maneja el NavigationPath y se encarga de navegación (navegación desacoplada de la vista).
- Las películas se almacenan localmente usando Realm. Si la API falla o no hay conexión, se muestran las películas previamente almacenadas. Además, se muestra un alert con mensaje de error si falla.
- Ordenadas por fecha (de la más reciente a la más antigua).
- Errores tipados usando un enum, con una variable con la descripción del error.