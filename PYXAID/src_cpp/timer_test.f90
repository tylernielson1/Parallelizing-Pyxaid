PROGRAM timer_test

USE mytimer_f90    ! f90 stubs for calling C timing routines

CALL Timer_Start( "Total Code" )

CALL Timer_Start( "Loop1" )
CALL Timer_Log_Flops( 100 )
CALL Timer_Stop( )

CALL Timer_Start( "Loop2" )
CALL Timer_Log_Bytes( 40000 )
CALL Timer_Stop( )

CALL Timer_Report( "time.out" )

END PROGRAM timer_test
