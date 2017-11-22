// Header file with C declarations for mytimer.c
// This is free software distributed under the GPL license

#include <stdint.h>   // for int64_t

void Timer_Start( char const * blockname );
void Timer_Stop( );
void Timer_Log_Flops( int64_t nflops );
void Timer_Log_Bytes( int64_t nbytes );
void Timer_Report( char const * timefilename );

