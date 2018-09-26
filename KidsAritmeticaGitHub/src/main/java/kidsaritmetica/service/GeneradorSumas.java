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
		
		if (suma.getNivel() == 1) {
				//suma = obtenerSumaPrimerNivel(sumasNivel);
		}
	}
	
/*private void generarSumasNivel (Map <Integer, List<Suma>> sumasNivel) {
		if (sumasNivel.get(2).size()<9) {
				obtenerSumaPrimerNivel(sumasNivel);
				generarSumasNivel(sumasNivel);
		}
	}*/
	
	public Suma obtenerSumaNivel(List<Suma> sumasNivel, int nivel, int colisiones, int maxColisiones) {
		Suma suma =  new Suma();
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		Integer digitoOp1 = getRandomIntegerBetween(0,nivel);
		Integer digitoOp2 = getRandomIntegerBetween(0,nivel);
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
		if (sumasNivel.contains(suma)) {
			colisiones++;
			if(colisiones<maxColisiones)
				suma = obtenerSumaNivel(sumasNivel,nivel,colisiones, maxColisiones);
		}
		else {
			sumasNivel.add(suma);
		}
		return suma;
	}

	private int getRandomIntegerBetween(int min, int max){
	    return  random.nextInt(max+1);
	}
	
	public static void main (String[] args) {
		GeneradorSumas generador = new GeneradorSumas();
		
		Map<Integer, List<Suma>> sumasNiveles = new HashMap<>();
		/*List<Suma> listaSumas = new ArrayList<>();
		sumasNiveles.put(1,listaSumas);
		generador.generarSumasNivel(sumasNiveles);
		for (Suma suma: sumasNiveles.get(1))
			System.out.println(""+suma.getOperando1() + " "+suma.getOperando2() );*/
		
		
		
		List<Suma> listaSumas2 = new ArrayList<>();
		sumasNiveles.put(2,listaSumas2);
		//generador.generarSumasNivel(sumasNiveles);
		for (Suma suma: sumasNiveles.get(2))
			System.out.println(""+suma.getOperando1() + " "+suma.getOperando2() );
		
	}

}
