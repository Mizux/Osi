function(parse_ac VERSION_STRING VERSION_MAJOR VERSION_MINOR VERSION_PATCH)
  file(READ "configure.ac" IN)
  if(IN MATCHES "AC_INIT\\(.*trunk.*\\)")
    message(WARNING "using trunk...")
    set(MAJOR 999)
    set(MINOR 0)
    set(PATCH 0)
  else()
    # AC_INIT([Osi],[major.minor.patch or trunk],[url or email])
    string(REGEX MATCH
      "AC_INIT\\([^,]+,\\[([0-9]+)\\.([0-9]+)(\\.([0-9]+))?\\],[^\\)]+\\)" AC_INIT ${IN})
    message(STATUS "AC_INIT: ${AC_INIT}")
    set(MAJOR ${CMAKE_MATCH_1})
    set(MINOR ${CMAKE_MATCH_2})
    if(CMAKE_MATCH_3)
      set(PATCH ${CMAKE_MATCH_4})
    else()
      set(PATCH 0)
    endif()
  endif()
  set(VERSION "${MAJOR}.${MINOR}.${PATCH}")

  set(${VERSION_MAJOR} ${MAJOR} PARENT_SCOPE)
  set(${VERSION_MINOR} ${MINOR} PARENT_SCOPE)
  set(${VERSION_PATCH} ${PATCH} PARENT_SCOPE)
  set(${VERSION_STRING} ${VERSION} PARENT_SCOPE)
  message(STATUS "version: ${VERSION}")
endfunction()