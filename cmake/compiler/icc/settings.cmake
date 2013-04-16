# Set build-directive (used in core to tell which buildtype we used)
add_definitions(-D_BUILD_DIRECTIVE="'${CMAKE_BUILD_TYPE}'")

if( SKIP_SSE2 )
  message(STATUS "ICC: MersenneTwister enabled, SSE2 flags not set")
  if( STANDARDIZE_ASM )
    message(STATUS "ICC: Using standardized ASM, good for cross-platform")
  endif()
else()
  if( STANDARDIZE_ASM )
    message(STATUS "ICC: Using standardized ASM, good for cross-platform. Also disabling SSE2")
    add_definitions(-DUSE_MERSENNETWISTER)
  else()
    if(PLATFORM EQUAL 32)
      add_definitions(-axSSE2)
    else()
      add_definitions(-xSSE2)
    endif()
  endif()
endif()

if( WITH_WARNINGS )
  add_definitions(-w1)
  message(STATUS "ICC: All warnings enabled")
endif()

if( WITH_COREDEBUG )
  add_definitions(-g)
  message(STATUS "ICC: Debug-flag set (-g)")
endif()