package playaddition.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import playaddition.model.Resta;



public class GeneradorRestas {
	
	Random random = new Random();

	public Resta obtenerRestaNivel(List<Resta> restasNivel, int nivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		Integer digitoOp1 = null;
		Integer digitoOp2 = null;
		resta.setNivel(nivel);
		if(nivel==1) {
			digitoOp1 = random.nextInt(nivel+1);
			if (digitoOp1==0)
				digitoOp2 = 0;
			else
				digitoOp2 = random.nextInt(digitoOp1+1);
		}else if(nivel==2 || nivel==3 || nivel==4) {
			digitoOp1 = random.nextInt(nivel+1);
			if (digitoOp1==0)
				digitoOp2 = 0;
			else
				digitoOp2 = random.nextInt(digitoOp1+1);
		}else if (nivel>=6 && nivel<=10) {
	    	digitoOp1 = random.nextInt(nivel);
			if (digitoOp1==0)
				digitoOp2 = 0;
			else
				digitoOp2 = random.nextInt(digitoOp1+1);
	    	
	    }
		digitosOperador1.add(digitoOp1);
		digitosOperador2.add(digitoOp2);
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		resta.setOperando1(operador1);
		resta.setOperando2(operador2);
		resta.setResultadoResta(operador1-operador2);
		
		if (nivelContainsResta(restasNivel, resta)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				System.out.println("colisiones: "+colisiones+" Nivel: "+nivel+" Suma "+resta);
				return obtenerRestaNivel(restasNivel,nivel,colisiones, maxColisiones);
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return null;
			}
		} else {
			System.out.println("Generada resta "+resta);
			return resta;
		}
	}
	
	public Resta getOperandosNivel12(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(12);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(10);
		int unidades2 = 0;
		
		if (unidades1==0)
			unidades2 = 0;
		else if (unidades1==1)
			unidades2 = 1;
		else
			unidades2 = random.ints(1, 1, unidades1+1).sum();
		int decenas1 =  1;
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		
		digitosOperador2.add(unidades2);
		
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		
		resta.setOperando1(operador1);
		resta.setOperando2(operador2);
		resta.setResultadoResta(operador1-operador2);
		
		if (restasNivel.contains(resta)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel12(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	private boolean nivelContainsResta(List<Resta> restasNivel, Resta resta) {
		Iterator<Resta> iter = restasNivel.iterator();
		while (iter.hasNext()) {
			Resta rest = iter.next();
			if (rest.getOperando1()==resta.getOperando1() && rest.getOperando2()==resta.getOperando2())
				return true;
		}
		return false;
	}

	public Resta getOperandosNivel13(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(13);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(9);
		int decenas1 =  1;
		int unidades2 = random.ints(1, unidades1+1, 10).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador2.add(unidades2);
		
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		
		resta.setOperando1(operador1);
		resta.setOperando2(operador2);
		resta.setResultadoResta(operador1-operador2);
		
		if (restasNivel.contains(resta)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel13(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel2425(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(13);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(9);
		int decenas1 =  random.ints(1, 5, 10).sum();
		
		int unidades2 = random.ints(1, unidades1+1, 10).sum();
		int decenas2 = random.ints(1, 1, decenas1).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador2.add(unidades2);
		digitosOperador2.add(decenas2);
		
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		
		resta.setOperando1(operador1);
		resta.setOperando2(operador2);
		resta.setResultadoResta(operador1-operador2);
		
		if (restasNivel.contains(resta)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel13(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
}
