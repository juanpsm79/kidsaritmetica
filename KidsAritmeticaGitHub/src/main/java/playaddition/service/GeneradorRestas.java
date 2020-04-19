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
		}else if(nivel==2) {
			digitoOp1 = random.nextInt(nivel+1);
			if (digitoOp1==0)
				digitoOp2 = 0;
			else
				digitoOp2 = random.nextInt(digitoOp1+1);
		}else if(nivel==3 || nivel==4) {
			digitoOp1 = random.ints(1, 1, nivel+1).sum();
			if (digitoOp1==0)
				digitoOp2 = 0;
			else
				digitoOp2 = random.ints(1, 1, digitoOp1+1).sum();
		} else if (nivel>=6 && nivel<=10) {
	    	digitoOp1 = random.ints(1, nivel-5, nivel).sum();
			digitoOp2 = random.ints(1, nivel-5, digitoOp1+1).sum();
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
		
		if (nivelContainsResta(restasNivel, resta) || (operador1==operador2 && nivel>1)){
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

		int unidades1 = random.ints(1, 2, 10).sum();
		int unidades2 = random.ints(1, 2, unidades1+1).sum();
		 
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
	
	public Resta getOperandosNivel15(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(15);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.ints(1, 2, 10).sum();
		int unidades2 = random.ints(1, 2, unidades1+1).sum();
		int decenas1 =  random.ints(1, 2, 5).sum();
		
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
				resta = getOperandosNivel15(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel1617(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(17);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(9);
		int decenas1 =  random.ints(1, 2, 5).sum();
		
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
				resta = getOperandosNivel1617(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel19(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(19);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.ints(1, 2, 10).sum();
		int unidades2 = random.ints(1, 2, unidades1+1).sum();
		int decenas1 =  random.ints(1, 5, 10).sum();
		
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
				resta = getOperandosNivel19(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel2021(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(21);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(9);
		int decenas1 =  random.ints(1, 5, 10).sum();
		
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
				resta = getOperandosNivel2021(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel23(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(23);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(10);
		int decenas1 =  random.ints(1, 1, 10).sum();
		
		int unidades2 = 0;
		if(unidades1>0)
			unidades2 = random.ints(1, 1, unidades1+1).sum();
		
		int decenas2 = random.ints(1, 1, decenas1+1).sum();
		
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
		
		if (restasNivel.contains(resta) || (operador1==operador2)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel23(restasNivel,colisiones, maxColisiones);
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
		resta.setNivel(25);
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
				resta = getOperandosNivel2425(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel27 (List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(27);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.ints(1, 1, 10).sum();
		int decenas1 =  random.ints(1, 1, 10).sum();
		int centenas1 = random.ints(1, 1, 10).sum();
		
		int unidades2 = random.ints(1, 1, unidades1+1).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
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
		
		if (restasNivel.contains(resta) || (operador1==operador2)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel27(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel2829 (List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(29);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(9);
		int decenas1 =  random.ints(1, 1, 10).sum();
		int centenas1 = random.ints(1, 1, 10).sum();
		
		int	unidades2 = random.ints(1, unidades1+1, 10).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
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
		
		if (restasNivel.contains(resta) || (operador1==operador2)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel2829(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}

	

	public Resta getOperandosNivel3031(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(31);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.ints(1, 1, 9).sum();
		int unidades2 = random.ints(1, unidades1+1, 10).sum();
		
		int decenas1 =  0;
		int centenas1 = random.ints(1, 1, 10).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
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
				resta = getOperandosNivel3031(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel33(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(33);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(10);
		int decenas1 =  random.ints(1, 1, 10).sum();
		int centenas1 = random.ints(1, 1, 10).sum();
		
		int unidades2 = 0;
		if(unidades1>0)
			unidades2 = random.ints(1, 1, unidades1+1).sum();
		int decenas2 = random.ints(1, 1, decenas1+1).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
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
		
		if (restasNivel.contains(resta) || (operador1==operador2)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel33(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel3435 (List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(35);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(9);
		int decenas1 =  random.ints(1, 2, 10).sum();
		int centenas1 = random.ints(1, 1, 10).sum();
		
		int	unidades2 = random.ints(1, unidades1+1, 10).sum();
		int	decenas2 = random.ints(1, 1, decenas1).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
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
		
		if (restasNivel.contains(resta) || (operador1==operador2)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel3435(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel3637(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(37);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(10);
		int decenas1 =  random.ints(1, 1, 9).sum();
		int centenas1 = random.ints(1, 1, 10).sum();
		
		int	unidades2 = 0;
		if(unidades1>0)
			unidades2 = random.ints(1, 1, unidades1+1).sum();
		int	decenas2 = random.ints(1, decenas1+1, 10).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
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
		
		if (restasNivel.contains(resta) || (operador1==operador2)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel3637(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel3839(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		resta.setNivel(39);
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();

		int unidades1 = random.nextInt(9);
		int unidades2 = random.ints(1, unidades1+1, 10).sum();
		
		int decenas1 =  random.ints(1, 1, 9).sum();
		int decenas2 = random.ints(1, decenas1+1, 10).sum();
		
		
		int centenas1 = random.ints(1, 1, 10).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
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
				resta = getOperandosNivel3839(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	

	public Resta getOperandosNivel4142(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		int operador1 = random.ints(1, 100, 1000).sum();
		int operador2 = random.ints(1, 10, 100).sum();
		
		operador1 = operador1 - 10*((operador1/10)%10);
		
		
		if(operador1%10<operador2%10) {
			int aux = random.ints(1, operador2%10, 10).sum();
			operador1 = operador1 - operador1%10 + aux;
		}
			
		resta.setOperando1(operador1);
		resta.setOperando2(operador2);
		resta.setResultadoResta(operador1-operador2);
		
		if (restasNivel.contains(resta)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel4142(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel4344(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		int operador1 = random.ints(1, 100, 1000).sum();
		int operador2 = random.ints(1, 10, 100).sum();
		
		operador1 = operador1 - 10*((operador1/10)%10);
		operador1 = operador1 - operador1%10 + random.ints(1, 0, 9).sum();
		
		if(operador1%10>=operador2%10) {
				int aux = random.ints(1, operador1%10+1, 10).sum();
				operador2 = operador2 - operador2%10 + aux;
		}
			
		resta.setOperando1(operador1);
		resta.setOperando2(operador2);
		resta.setResultadoResta(operador1-operador2);
		
		if (restasNivel.contains(resta)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel4344(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel46(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		int operador1 = random.ints(1, 100, 1000).sum();
		int operador2 = random.ints(1, 100, 1000).sum();
		
		if(operador1%10<operador2%10) {
			int aux = random.ints(1, operador2%10, 10).sum();
			operador1 = operador1 - operador1%10 + aux;
		}
		
		if((operador1/10)%10 < (operador2/10)%10) {
			int aux = random.ints(1, (operador2/10)%10, 10).sum();
			operador1 = operador1 - 10*((operador1/10)%10) + 10*aux;
		}
		
		if((operador1/100)%10 < (operador2/100)%10) {
			int aux = random.ints(1, (operador2/100)%10, 10).sum();
			operador1 = operador1 - 100*((operador1/100)%10) + 100*aux;
		}
			
		resta.setOperando1(operador1);
		resta.setOperando2(operador2);
		resta.setResultadoResta(operador1-operador2);
		
		if (restasNivel.contains(resta)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel46(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			return resta;
		}
	}
	
	public Resta getOperandosNivel4748(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		int operador1 = random.ints(1, 100, 1000).sum();
		int operador2 = random.ints(1, 100, 1000).sum();
		
		//sumamos unidades a operador2 para que supere en unidades a operador1 que no puede tener un 9 en unidadeos
		operador1 = operador1 - operador1%10 + random.ints(1, 0, 9).sum();
		if(operador1%10>=operador2%10)
			operador2 = operador2 - operador2%10 + random.ints(1, operador1%10+1, 10).sum();
		
		//decenas del sustraendo menor que el minuendo->las decenas del sustraendo no pueden ser 9
		operador2 = operador2 - 10*((operador2/10)%10) + 10*random.ints(1, 0, 9).sum();
		if((operador1/10)%10 <= (operador2/10)%10) 
			operador1 = operador1 - 10*((operador1/10)%10) + 10*random.ints(1, (operador2/10)%10+1, 10).sum();
		
		
		if((operador1/100)%10 < (operador2/100)%10)  
			operador1 = operador1 - 100*((operador1/100)%10) + 100*random.ints(1, (operador2/100)%10, 10).sum();
			
		resta.setOperando1(operador1);
		resta.setOperando2(operador2);
		resta.setResultadoResta(operador1-operador2);
		
		if (restasNivel.contains(resta)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel4748(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			
			return resta;
		}
	}
	
	public Resta getOperandosNivel4950(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		int operador1 = random.ints(1, 100, 1000).sum();
		int operador2 = random.ints(1, 100, 1000).sum();
		
		//sumamos unidades a operador2 para que supere en unidades a operador1 que no puede tener un 9 en unidadeos
		if(operador1%10<operador2%10)
			operador1 = operador1 - operador1%10 + random.ints(1, operador2%10, 10).sum();
		
		//decenas del sustraendo mayor que el minuendo->las decenas del minuendo no pueden ser 9
		operador1 = operador1 - 10*((operador1/10)%10) + 10*random.ints(1, 0, 9).sum();
		if((operador1/10)%10 >= (operador2/10)%10) 
			operador2 = operador2 - 10*((operador2/10)%10) + 10*random.ints(1, (operador1/10)%10+1, 10).sum();
		
		//sustraendo estrictamente menor minuendo
		operador2 = operador2 - 100*((operador2/100)%10) + 100*random.ints(1, 1, 9).sum();
		if((operador1/100)%10 <= (operador2/100)%10)  
			operador1 = operador1 - 100*((operador1/100)%10) + 100*random.ints(1, (operador2/100)%10+1, 10).sum();
			
		resta.setOperando1(operador1);
		resta.setOperando2(operador2);
		resta.setResultadoResta(operador1-operador2);
		
		if (restasNivel.contains(resta)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel4950(restasNivel,colisiones, maxColisiones);
				return resta;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+resta);
				return resta;
			}
		} else {
			
			return resta;
		}
	}
	
	public Resta getOperandosNivel5152(List<Resta> restasNivel, Integer colisiones, int maxColisiones) throws Exception {
		Resta resta =  new Resta();
		int operador1 = random.ints(1, 100, 1000).sum();
		int operador2 = random.ints(1, 100, 1000).sum();
		
		//Unidade y decenas sustraendo mayor minuendo->no 9's en unidades y decenas minuendo
		operador1 = operador1 - operador1%10 + random.ints(1, 0, 9).sum();
		operador1 = operador1 - 10*((operador1/10)%10) + 10*random.ints(1, 0, 9).sum();
		
		if(operador1%10 >= operador2%10)
			operador2 = operador2 - operador2%10 + random.ints(1, operador1%10+1, 10).sum();
		
		//decenas del sustraendo mayor que el minuendo
		if((operador1/10)%10 >= (operador2/10)%10) 
			operador2 = operador2 - 10*((operador2/10)%10) + 10*random.ints(1, (operador1/10)%10+1, 10).sum();
		
		//sustraendo estrictamente menor minuendo
		operador2 = operador2 - 100*((operador2/100)%10) + 100*random.ints(1, 1, 9).sum();
		if((operador1/100)%10 <= (operador2/100)%10)  
			operador1 = operador1 - 100*((operador1/100)%10) + 100*random.ints(1, (operador2/100)%10+1, 10).sum();
			
		resta.setOperando1(operador1);
		resta.setOperando2(operador2);
		resta.setResultadoResta(operador1-operador2);
		
		if (restasNivel.contains(resta)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				resta = getOperandosNivel5152(restasNivel,colisiones, maxColisiones);
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

	private boolean nivelContainsResta2(List<Resta> restasNivel, Resta resta) {
		Iterator<Resta> iter = restasNivel.iterator();
		while (iter.hasNext()) {
			Resta rest = iter.next();
			if (rest.getOperando1()==resta.getOperando1() || rest.getOperando2()==resta.getOperando2())
				return true;
		}
		return false;
	}

	

	/*public static void main (String args[]) {
		Random random = new Random();
		int operador1 = random.ints(1, 100, 1000).sum();
		int operador2 = random.ints(1, 100, 1000).sum();
		for (int i=0;i<=400;i++) {
			 //operador1 = random.ints(1, 100, 1000).sum();
			operador1 = random.ints(1, 100, 1000).sum();
			System.out.println(operador1);
			int aux1 = operador1%10;
			System.out.println(aux1);
			int aux = random.ints(1, 0, 9).sum();
			System.out.println(aux);
			operador1 = operador1 - aux1 + aux;
			System.out.println(operador1);
			System.out.println("-------------");
		}
		operador1 = operador1 - operador1%10 + random.ints(1, 0, 9).sum();
		if(operador1%10>=operador2%10)
			operador2 = operador2 - operador2%10 + random.ints(1, operador1%10+1, 10).sum();
		
		//decenas del sustraendo menor que el minuendo->las decenas del sustraendo no pueden ser 9
		operador2 = operador2 - 10*((operador2/10)%10) + 10*random.ints(1, 0, 9).sum();
		if((operador1/10)%10 <= (operador2/10)%10) 
			operador1 = operador1 - 10*((operador1/10)%10) + 10*random.ints(1, (operador2/10)%10+1, 10).sum();
		
		
		if((operador1/100)%10 < (operador2/100)%10)  
			operador1 = operador1 - 100*((operador1/100)%10) + 100*random.ints(1, (operador2/100)%10, 10).sum();
		
		//System.out.println(operador1);
		//System.out.println(operador2);
	}*/
	
}
