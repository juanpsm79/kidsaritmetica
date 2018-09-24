package kidsaritmetica.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import kidsaritmetica.model.Suma;

public class GeneradorSumas {
	
	Random random = new Random();
	
	private void generarOperadores (Suma suma, Map <Integer, List<Suma>> sumasNivel) {
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		if (suma.getNivel() == 1) {
			Integer digitoOp1 = getRandomIntegerBetween(0,1);
			Integer digitoOp2 = getRandomIntegerBetween(0,1);
			digitosOperador1.add(digitoOp1);
			digitosOperador2.add(digitoOp2);
			int operador1 = 0;
			int operador2 = 0;
			for(int i=0; i<digitosOperador1.size();i++)
				operador1+=(10)^i + digitosOperador1.get(i);
			for(int i=0; i<digitosOperador2.size();i++)
				operador2+=(10)^i + digitosOperador2.get(i);
				
			
		}
	}
	
	private int getRandomIntegerBetween(int min, int max){
	    return  random.nextInt(max+1);
	}

}
