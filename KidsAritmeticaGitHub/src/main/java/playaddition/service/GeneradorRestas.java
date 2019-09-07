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
			digitoOp1 = new Random().nextInt(nivel+1);
			if (digitoOp1==0)
				digitoOp2 = 0;
			else
				digitoOp2 = new Random().nextInt(digitoOp1+1);
		}else if(nivel==2) {
			digitoOp1 = new Random().nextInt(nivel+1);
			if (digitoOp1==0)
				digitoOp2 = 0;
			else
				digitoOp2 = new Random().nextInt(digitoOp1+1);
		}else if(nivel==3 || nivel==4) {
			digitoOp1 = new Random().ints(1, 1, nivel+1).sum();
			if (digitoOp1==0)
				digitoOp2 = 0;
			else
				digitoOp2 = new Random().ints(1, 1, digitoOp1+1).sum();
		} else if (nivel>=6 && nivel<=10) {
	    	digitoOp1 = new Random().ints(1, nivel-5, nivel).sum();
			if (digitoOp1==0)
				digitoOp2 = 0;
			else
				digitoOp2 = new Random().ints(1, nivel-5, digitoOp1+1).sum();
	    	
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

		int unidades1 = new Random().nextInt(10);
		int unidades2 = 0;
		
		if (unidades1==0)
			unidades2 = 0;
		else if (unidades1==1)
			unidades2 = 1;
		else
			unidades2 = new Random().ints(1, 1, unidades1+1).sum();
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

		int unidades1 = new Random().nextInt(9);
		int decenas1 =  1;
		int unidades2 = new Random().ints(1, unidades1+1, 10).sum();
		
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

		int unidades1 =  new Random().ints(1, 2, 10).sum();
		int decenas1 =  new Random().ints(1, 2, 5).sum();
		
		int unidades2 = 0;
		if(unidades1>0)
		   unidades2 = new Random().ints(1, 2, unidades1+1).sum();
		
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

		int unidades1 = new Random().nextInt(9);
		int decenas1 =  new Random().ints(1, 2, 5).sum();
		
		int unidades2 = new Random().ints(1, unidades1+1, 10).sum();
		
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

		int unidades1 = new Random().nextInt(10);
		int decenas1 =  new Random().ints(1, 5, 10).sum();
		
		int unidades2 = 0;
		if(unidades1>0)
		   unidades2 = new Random().ints(1, 1, unidades1+1).sum();
		
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

		int unidades1 = new Random().nextInt(9);
		int decenas1 =  new Random().ints(1, 5, 10).sum();
		
		int unidades2 = new Random().ints(1, unidades1+1, 10).sum();
		
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

		int unidades1 = new Random().nextInt(10);
		int decenas1 =  new Random().ints(1, 1, 10).sum();
		
		int unidades2 = 0;
		if(unidades1>0)
			unidades2 = new Random().ints(1, 1, unidades1+1).sum();
		
		int decenas2 = new Random().ints(1, 1, decenas1+1).sum();
		
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

		int unidades1 = new Random().nextInt(9);
		int decenas1 =  new Random().ints(1, 5, 10).sum();
		
		int unidades2 = new Random().ints(1, unidades1+1, 10).sum();
		int decenas2 = new Random().ints(1, 1, decenas1).sum();
		
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

		int unidades1 = new Random().nextInt(10);
		int decenas1 =  new Random().ints(1, 1, 10).sum();
		int centenas1 = new Random().ints(1, 1, 10).sum();
		
		int unidades2 = 0;
		if(unidades1>0)
			unidades2 = new Random().ints(1, 1, unidades1+1).sum();
		
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

		int unidades1 = new Random().nextInt(9);
		int decenas1 =  new Random().ints(1, 1, 10).sum();
		int centenas1 = new Random().ints(1, 1, 10).sum();
		
		int	unidades2 = new Random().ints(1, unidades1+1, 10).sum();
		
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

		int unidades1 = new Random().ints(1, 1, 9).sum();
		int unidades2 = new Random().ints(1, unidades1+1, 10).sum();
		
		int decenas1 =  0;
		int centenas1 = new Random().ints(1, 1, 10).sum();
		
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

		int unidades1 = new Random().nextInt(10);
		int decenas1 =  new Random().ints(1, 1, 10).sum();
		int centenas1 = new Random().ints(1, 1, 10).sum();
		
		int unidades2 = 0;
		if(unidades1>0)
			unidades2 = new Random().ints(1, 1, unidades1+1).sum();
		int decenas2 = new Random().ints(1, 1, decenas1+1).sum();
		
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

		int unidades1 = new Random().nextInt(9);
		int decenas1 =  new Random().ints(1, 2, 10).sum();
		int centenas1 = new Random().ints(1, 1, 10).sum();
		
		int	unidades2 = new Random().ints(1, unidades1+1, 10).sum();
		int	decenas2 = new Random().ints(1, 1, decenas1).sum();
		
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

		int unidades1 = new Random().nextInt(10);
		int decenas1 =  new Random().ints(1, 1, 9).sum();
		int centenas1 = new Random().ints(1, 1, 10).sum();
		
		int	unidades2 = 0;
		if(unidades1>0)
			unidades2 = new Random().ints(1, 1, unidades1+1).sum();
		int	decenas2 = new Random().ints(1, decenas1+1, 10).sum();
		
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

		int unidades1 = new Random().nextInt(9);
		int unidades2 = new Random().ints(1, unidades1+1, 10).sum();
		
		int decenas1 =  new Random().ints(1, 1, 9).sum();
		int decenas2 = new Random().ints(1, decenas1+1, 10).sum();
		
		
		int centenas1 = new Random().ints(1, 1, 10).sum();
		
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
	
	private boolean nivelContainsResta(List<Resta> restasNivel, Resta resta) {
		Iterator<Resta> iter = restasNivel.iterator();
		while (iter.hasNext()) {
			Resta rest = iter.next();
			if (rest.getOperando1()==resta.getOperando1() && rest.getOperando2()==resta.getOperando2())
				return true;
		}
		return false;
	}

	

	

	

	

	
}
