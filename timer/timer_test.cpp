// classes example
#include <stdlib.h>
#include <iostream>
#include <string>
#include "mytimer_cpp.h"
#include <omp.h>

using namespace std;

class Rectangle {
  private:
    static int _width, _height;
    //int width, height;
  public:
    void set_values (int,int);
    int area() {return _width * _height;}
};

void Rectangle::set_values (int x, int y) {
  _width = x;
  _height = y;
}

int Rectangle::_width;
int Rectangle::_height;

int main () {
  double sum = 0.0, *x, *y;
  int i;

  Timer timer( "Total" );

  timer.Start( "calculations" );

  x = (double *) malloc( 100000*sizeof(double) );
  y = (double *) malloc( 100000*sizeof(double) );

  omp_set_num_threads( 4 );

#pragma omp parallel
  {
    timer.Start( "para section" );

    timer.Start( "para1" );
#pragma omp for reduction(+: sum)
    for( i=0; i<10000; i++ ) sum += x[i] * y[i];

#pragma omp for
    for( i=0; i<10000; i++ ) x[i] = x[i] * y[i];

    timer.Stop();  // Stop para

    timer.Start( "para2" );

#pragma omp for
    for( i=0; i<10000; i++ ) y[i] = y[i] * x[i];

#pragma omp for reduction(+: sum)
    for( i=0; i<10000; i++ ) sum += x[i] * y[i];

    timer.Stop();  // Stop para2
    timer.Stop();  // Stop para
  }

  timer.Stop();  // Stop calculations

  timer.Start( "the rest" );
  Rectangle rect;

  rect.set_values (3,4);
  cout << "area: " << rect.area() << '\n';
  timer.Stop();  // Stop the rest

  //timer.Stop();  // Stop total time

cout << "Before timer_report\n";
  timer.Report( "time.out" );
cout << "After timer_report\n";
  return 0;
}
