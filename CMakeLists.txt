cmake_minimum_required(VERSION 3.16)

project(DiskMark VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick Widgets REQUIRED)

# CODE PATH
qt_add_executable(appDiskMark
    src/main.cpp
    src/application.h
    src/application.cpp
    src/applicationsettings.h
    src/applicationsettings.cpp
    src/benchmark.h
    src/benchmark.cpp
    src/global.h
    src/global.cpp
)

# QML path
list(APPEND QML_DIRS "src/qml")
set(QML_IMPORT_PATH "${QML_DIRS}")
qt_add_qml_module(appDiskMark
    URI DiskMark
    VERSION 1.0
    QML_FILES
        ${QML_DIRS}/main.qml

#        ${QML_DIRS}/ui/AboutDialog.qml
        ${QML_DIRS}/ui/MyButton.qml
        ${QML_DIRS}/ui/MyComboBox.qml
        ${QML_DIRS}/ui/MyProgressBar.qml
)

set(TS_FILES
    data/translations/${PROJECT_NAME}_en_US.ts
)

set_target_properties(appDiskMark PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER arielen
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appDiskMark
    PRIVATE
        Qt6::Quick
        Qt::Widgets
)

install(TARGETS appDiskMark
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
