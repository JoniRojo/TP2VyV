
// Variables Globales

byte A[10];
bool m[10];
byte max = 0;
byte maximo = 0;
byte count = 0;
byte q = 0;
byte n = 10;
byte term = 0;
byte aux = n*n;
byte i;
byte j;
byte z;


// Verificacion de que el arreglo a tratar eventualmente termina

ltl termina { <> (term == n)}


proctype ArrayTrue(byte t)
{
    m[t] = true;
    count++;
}

proctype ArrayComp(byte t; byte p)
{

    if
    :: (A[t] < A[p]) -> m[t] = false; 
    :: else -> skip;
    fi
    count++;
}

proctype ArrayMax(byte t)
{
    if
    :: (m[t] == true) -> max = A[t];
    :: else -> skip
    fi
    count++;
    term++;
}

proctype Array(byte k){

    do
    :: A[k] = k * 5 / 2; break;
    :: A[k] = k + 12 * 4; break;
    :: A[k] = k + 100 / 10; break;
    :: A[k] = k / 10 + 32; break;
    :: A[k] = k + 100 + 32; break;
    od 

}


proctype ArrayLineal(byte y){
        
        if
        :: (A[y] > maximo) -> maximo = A[y]; 
        :: else -> skip;
        fi
        count++;
}


init
{   

    // Cargamos el arreglo de byte.
    for(q: 0 .. (n-1)){
        run Array(q);
    }
    

    // Imprimimos el arreglo cargado.
    for(q: 0 .. (n-1)){
        printf("A[%d]= %d\n",q,A[q]);
    } 


    // Cargamos el arreglo booleano.
    for (i: 0 .. n-1) {
        run ArrayTrue(i);
    }


    //  Hacemos un bloqueo.
    (count ==  n) 

    count = 0;
        

    // Hacemos las comparaciones
    for (i: 0 .. (n-1)) {
        for (j: 0 .. (n-1)) {
            
            run ArrayComp(i, j); 

        }
    }

    (count == aux); 

    count = 0;

    // Buscamos el valor maximo del Arreglo
    for (i: 0 .. (n-1)) {
        run ArrayMax(i);
    }

    (count == n);
    
    count = 0;

    // Buscamos en otro proceso el valor maximo para despues hacer la verificacion.
    for(z: 0 .. (n-1)){
        run ArrayLineal(z);
    }

    (count == n);


    printf("El máximo valor es: %d\n", max);
    
    printf("Maximo es %d\n",maximo);

    // Verificacion del maximo del arreglo.
    assert(maximo == max);


}


