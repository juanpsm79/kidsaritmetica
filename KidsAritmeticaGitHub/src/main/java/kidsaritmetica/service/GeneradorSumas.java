package kidsaritmetica.service;

import java.util.ArrayList;
import java.util.HashMap;
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
				operador1+=Math.pow(10,i) * digitosOperador1.get(i);
			for(int i=0; i<digitosOperador2.size();i++)
				operador2+=Math.pow(10,i) * digitosOperador2.get(i);
			suma.setOperando1(operador1);
			suma.setOperando2(operador2);
			if (sumasNivel.get(1).contains(suma))
				System.out.println("Suma contenida");
		}
	}
	
	private int getRandomIntegerBetween(int min, int max){
	    return  random.nextInt(max+1);
	}
	
	public static void main (String[] args) {
		GeneradorSumas generador = new GeneradorSumas();
		Suma suma = new Suma();
		suma.setNivel(1);
		Map<Integer, List<Suma>> sumasNiveles = new HashMap<>();
		List<Suma> listaSumas = new ArrayList<>();
		listaSumas.add(new Suma(0,0));
		sumasNiveles.put(1,listaSumas);
		generador.generarOperadores(suma, sumasNiveles);
		System.out.println(""+suma.getOperando1() + " "+suma.getOperando2() );
	}

}
