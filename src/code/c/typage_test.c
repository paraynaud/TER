void test_typage(float x){
	x = ( 0 == 0);
	x = 4 ;
}


void test_typage2(int x){
	int y ;
	if( x+3 < 5 && x > 0 && x > 1){
		y = (x == x) ;
	}
	else{
		y = 5 ;
	}
}


void typage(int x ){
	int y;
	if ( x > 2 ){
		y = (x == x) ;
	}
	else{
		y = 4 ;
	}

}

void typage2(int x){
	int y = x << 2 ;

}


void tableau(int i, int t[50]){
	t[i] =0;
}


struct My_struct
{
	int obj1;
	float obj2;
};

struct Struct_dep
{
	struct My_struct e1;
	int indicator;

};

void test_struct(int indicator, int o1, float o2 ){
	struct Struct_dep sd;
	sd.e1.obj1 = o1;
	sd.e1.obj2 = o2;
	sd.indicator = indicator;
}

void test_operation(int x, int y, int z){
	float v = x + y + ( 2 * z) + (x == x) ;
}

void test_condition(){
	int x;
	if(x){
		x = (x == (0==1));
	}
}

void test_condition_complet(){
	int x;
	if(x){
		x = (x == (0==1));
	}
	else {
		x = 5 ;
	}
}

void test_condition_complet_arg(int x){
	if(x){
		x = (x == (0==1));
	}
	else {
		x = 5 ;
	}
}


void test_appel(float y){
	typage2(y);
}


void test_double_condition(int x){
	int y;
	if ( x < 5 && x > 1 ){
		y = 3;
	}
	else{
		y = 2;
	}
}



