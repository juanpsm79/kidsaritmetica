package kidsaritmetica.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import kidsaritmetica.model.Suma;

public class GeneradorSumas {
	
	Random random = new Random();
	
	public Suma obtenerSumaNivel(List<Suma> sumasNivel, int nivel, int colisiones, int maxColisiones) {
		Suma suma =  new Suma();
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		System.out.println("colisiones: "+colisiones);
		Integer digitoOp1 = null;
		Integer digitoOp2 = null;
		
		if(nivel<5) {
			digitoOp1 =  random.nextInt(nivel+1);
			digitoOp2 = random.nextInt(nivel+1);
		}else if (nivel==5) {
			int nivelAleatorio = random.ints(1, 1, 5).sum(); //límite superior exclusivo
			digitoOp1 =  random.ints(1, 0, nivelAleatorio+1).sum();
			digitoOp2 = random.ints(1, 0, nivelAleatorio+1).sum();
	    }else if (nivel>=6 && nivel<=10) {
	    	digitoOp1 = random.nextInt(nivel);
	    	if(nivel==6) {
		    	if(digitoOp1<5)
		    		digitoOp2 = random.nextInt(nivel);
		    	else
		    		digitoOp2 = random.ints(1, 0, nivel-digitoOp1).sum();
	    	} else if(nivel==7) {
	    		digitoOp1 = random.nextInt(nivel);
		    	if(digitoOp1<4)
		    		digitoOp2 = random.nextInt(nivel);
		    	else
		    		digitoOp2 = random.ints(1, 0, nivel-digitoOp1).sum();
	    	} else if(nivel==8) {
	    		digitoOp1 = random.nextInt(nivel);
		    	if(digitoOp1<3)
		    		digitoOp2 = random.nextInt(nivel);
		    	else
		    		digitoOp2 = random.ints(1, 0, nivel-digitoOp1).sum();
	    	} else if(nivel==9) {
	    		digitoOp1 = random.nextInt(nivel);
		    	if(digitoOp1<2)
		    		digitoOp2 = random.nextInt(nivel);
		    	else
		    		digitoOp2 = random.ints(1, 0, 10-digitoOp1).sum();
	    	} else if(nivel==10) {
	    		digitoOp1 = random.nextInt(nivel);
		    	digitoOp2 = random.ints(1, 0, nivel-digitoOp1).sum();
	    	}
	    }else if (nivel==11) {
	    	int nivelAleatorio = random.ints(1, 6, 11).sum();
	    	Suma suma1 = obtenerSumaNivel(sumasNivel, nivelAleatorio, colisiones, maxColisiones);
	    	digitoOp1 = suma1.getOperando1();
			digitoOp2 = suma1.getOperando2();
	    } else if (nivel==12) {
	    	//regrouping in units
	    	digitoOp1 =  random.ints(1, 1, 10).sum();
	    	digitoOp2 = random.ints(1, 10-digitoOp1,10).sum();
	    } else if(nivel==13) {
	    	int nivelAleatorio = random.ints(1, 8, 13).sum();
	    	Suma suma1 = obtenerSumaNivel(sumasNivel, nivelAleatorio, colisiones, maxColisiones);
	    	digitoOp1 = suma1.getOperando1();
			digitoOp2 = suma1.getOperando2();
	    }
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
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = obtenerSumaNivel(sumasNivel,nivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel14(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//two digits/one digit addition without regrouping
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//sin llevada
		int unidades1 =  random.nextInt(10);
		int unidades2 = random.nextInt(10-unidades1);
		
		
		//sin llevada
		int decenas1 =  random.ints(1, 1, 10).sum();
		int decenas2 = 0;
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel14(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel15(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//two digits/one digit addition with regrouping in units only
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//regrouping in untis
		int unidades1 =  random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
		
		
		//sin llevada
		int decenas1 =  random.ints(1, 1, 9).sum();
		int decenas2 = 0;
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel15(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel16(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//two digits/one digit addition with regrouping in units and tens
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//regrouping in untis
		int unidades1 =  random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
		
		
		//sin llevada
		int decenas1 =  9;
		int decenas2 = 0;
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel16(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel18(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//two digits/two digits without regrouping
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//sin llevada
		int unidades1 = random.ints(1, 1, 10).sum();
		int unidades2 = 0;
		if(unidades1<9)
			unidades2 = random.ints(1, 1, 10-unidades1).sum();
		
		
		
		//sin llevada
		int decenas1 = random.ints(1, 1, 9).sum();
		int decenas2 = random.ints(1, 1, 10-decenas1).sum();
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel18(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel19(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//two digits/two digits with regrouping in untis
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//regrouping in units
		int unidades1 = random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
		
		
		//sin llevada
		int decenas1 = random.ints(1, 1, 8).sum();
		int decenas2 = random.ints(1, 1, 10-decenas1-1).sum();
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel19(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel20(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//two digits/two digits regrouping in tens
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		int unidades1 =  random.nextInt(10);
		int unidades2 = random.nextInt(10-unidades1);
		
		int decenas1 =  random.ints(1, 1, 10).sum();
		int decenas2 = random.ints(1, 10-decenas1, 10).sum();
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		if (sumasNivel.contains(suma) || suma.getResultadoSuma()>109){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel20(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
		
	}
	
	public Suma getOperandosNivel21(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//two digits/two digits regrouping in units and tens
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		int unidades1 =  random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
		
		int decenas1 =  random.ints(1, 1, 10).sum();
		int decenas2 = random.ints(1, 10-decenas1, 10).sum();
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel21(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}

	public Suma getOperandosNivel23(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 23: three digits/one digit addition without regrouping
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		int unidades1 = random.nextInt(10);
		int unidades2 = random.nextInt(10-unidades1);
		
		int decenas1 =  random.ints(1, 1, 10).sum();
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel23(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}

	
	public Suma getOperandosNivel24(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 24: three digits/one digit addition with regrouping in units
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//regrouping in units
		int unidades1 = random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
				
				
		//sin llevada
		int decenas1 = random.ints(1, 1, 9).sum();
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel24(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	
	public Suma getOperandosNivel26(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 26: three digits/two digits addition without regrouping
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//sin llevada
		int unidades1 = random.nextInt(10);
		int unidades2 = 0;
		if(unidades1<9)
			unidades2 = random.ints(1, 1, 10-unidades1).sum();
				
				
		//sin llevada
		int decenas1 = random.nextInt(9);
		int decenas2 = random.ints(1, 1, 10-decenas1).sum();
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	
	public Suma getOperandosNivel27(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 27: Three digits/two digits addition with regrouping in units
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//llevada en las unidades
		int unidades1 = random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
				
				
		//sin llevada
		int decenas1 = random.nextInt(8);
		int decenas2 = 1;
		if(decenas1<7)
		 decenas2 = random.ints(1, 1, 9-decenas1).sum();
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel28(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 28: three digits/two digits addition with regrouping in tens
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//sin llevada unidades
		int unidades1 = random.nextInt(10);
		int unidades2 = 0;
		if(unidades1<9)
			unidades2 = random.ints(1, 1, 10-unidades1).sum();
				
				
		//llevada unidades
		int decenas1 = random.ints(1, 1, 10).sum();
		int decenas2 = random.ints(1, 10-decenas1, 10).sum();
		
		int centenas1 = random.ints(1, 1, 9).sum();
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	
	public Suma getOperandosNivel29(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 29: three digits/two digits addition with regrouping in units and tens
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//con llevada unidades
		int unidades1 = random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
				
				
		//llevada decenas
		//+1
		int decenas1 = random.nextInt(10);
		int decenas2 = random.ints(1, 10-decenas1-1, 10).sum();
		
		int centenas1 = random.ints(1, 1, 9).sum();
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	
	public Suma getOperandosNivel30(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 30: three digits/two digits addition with regrouping in hundreds and tens
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//sin llevada unidades
		int unidades1 = random.nextInt(10);
		int unidades2 = random.ints(1, 0, 10-unidades1).sum();
				
				
		//llevada decenas
		int decenas1 = random.ints(1, 1, 10).sum();
		int decenas2 = random.ints(1, 10-decenas1, 10).sum();
		
		int centenas1 = 9;
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	
	public Suma getOperandosNivel31(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 31: three digits/two digits addition with regrouping in units tens and hundreds
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//con llevada unidades
		int unidades1 = random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
				
				
		//llevada decenas
		//+1
		int decenas1 = random.nextInt(10);
		int decenas2 = random.ints(1, 10-decenas1-1, 10).sum();
		
		int centenas1 = 9;
		
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
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel33(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 33: three digits/three digits addition without regrouping
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//sin llevada unidades
		int unidades1 = random.nextInt(10);
		int unidades2 = 0;
		if(unidades1<9)
			unidades2 = random.ints(1, 1, 10-unidades1).sum();
								
		//sin llevada decenas
		int decenas1 = random.nextInt(10);
		int decenas2 = 0;
		if(decenas1<9)
			decenas2 = random.ints(1, 1, 10-decenas1).sum();
		
		
		//sin llevada centenas
		int centenas1 =  random.ints(1, 1, 9).sum();
		int centenas2 = 1;
		if (centenas1<8)
			centenas2 =  random.ints(1, 1, 10-centenas1).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
		
		digitosOperador2.add(unidades2);
		digitosOperador2.add(decenas2);
		digitosOperador2.add(centenas2);
		
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel34(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 34: three digits/three digits addition with regrouping in units
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//llevada en las unidades
		int unidades1 = random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
						
						
		//sin llevada decenas
		int decenas1 = random.nextInt(8);
		int decenas2 = 1;
		if(decenas1<7)
		 decenas2 = random.ints(1, 1, 9-decenas1).sum();
		
		
		//sin llevada centenas
		int centenas1 =  random.ints(1, 1, 9).sum();
		int centanas2 = 1;
		if(centenas1<8)
			centanas2 =	random.ints(1, 1, 10-centenas1).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
		
		digitosOperador2.add(unidades2);
		digitosOperador2.add(decenas2);
		digitosOperador2.add(centanas2);
		
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	
	public Suma getOperandosNivel35(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 35: three digits/three digits addition with regrouping in tens
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//sin llevada unidades
		int unidades1 = random.nextInt(10);
		int unidades2 = 0;
		if(unidades1<9)
			unidades2 = random.ints(1, 1, 10-unidades1).sum();
				
		//llevada decenas
		int decenas1 = random.ints(1, 1, 10).sum();
		int decenas2 = random.ints(1, 10-decenas1, 10).sum();
		
		//sin llevada centenas
		int centenas1 = random.ints(1, 1, 8).sum();
		int centanas2 = 1;
		if(centenas1<7)
			centanas2 = random.ints(1, 1, 9-centenas1).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
		
		digitosOperador2.add(unidades2);
		digitosOperador2.add(decenas2);
		digitosOperador2.add(centanas2);
		
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel36(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 36: three digits/three digits addition with regrouping in units and tens
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//con llevada unidades
		int unidades1 = random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
						
		//llevada decenas
		//+1
		int decenas1 = random.ints(1, 1, 10).sum();
		int decenas2 = random.ints(1, 10-decenas1-1, 10).sum();
		
		//sin llevada centenas
		int centenas1 = random.ints(1, 1, 8).sum();
		int centanas2 = 1;
		if(centenas1<7)
			centanas2 = random.ints(1, 1, 9-centenas1).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
		
		digitosOperador2.add(unidades2);
		digitosOperador2.add(decenas2);
		digitosOperador2.add(centanas2);
		
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	
	public Suma getOperandosNivel37(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 37: three digits/three digits addition with regrouping in units and hundreds
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//llevada en las unidades
		int unidades1 = random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
						
						
		//sin llevada decenas
		int decenas1 = random.nextInt(8);
		int decenas2 = 1;
		if(decenas1<7)
		 decenas2 = random.ints(1, 1, 9-decenas1).sum();
		
		
		//con llevada centenas
		int centenas1 = random.ints(1, 1, 10).sum();
		int centanas2 = random.ints(1, 10-centenas1, 10).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
		
		digitosOperador2.add(unidades2);
		digitosOperador2.add(decenas2);
		digitosOperador2.add(centanas2);
		
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	
	public Suma getOperandosNivel38(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 37: three digits/three digits addition with regrouping in tens and hundreds
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//sin llevada unidades
		int unidades1 = random.nextInt(10);
		int unidades2 = 0;
		if(unidades1<9)
			unidades2 = random.ints(1, 1, 10-unidades1).sum();
		
		//con llevada decenas
		int decenas1 = random.ints(1, 1, 10).sum();
		int decenas2 = random.ints(1, 10-decenas1, 10).sum();
				
		//llevada centenas
		//+1
		int centenas1 = random.ints(1, 1, 10).sum();
		int centenas2 = random.ints(1, 10-centenas1-1, 10).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
		
		digitosOperador2.add(unidades2);
		digitosOperador2.add(decenas2);
		digitosOperador2.add(centenas2);
		
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}
	
	public Suma getOperandosNivel39(List<Suma> sumasNivel, int colisiones, int maxColisiones) {
		//Level 39: three digits/three digits addition with regrouping in units tens and hundreds
		List<Integer> digitosOperador1 = new ArrayList<Integer>();
		List<Integer> digitosOperador2 = new ArrayList<Integer>();
		
		//sin llevada unidades
		int unidades1 = random.ints(1, 1, 10).sum();
		int unidades2 = random.ints(1, 10-unidades1, 10).sum();
		
		//con llevada decenas
		int decenas1 = random.ints(1, 1, 10).sum();
		int decenas2 = random.ints(1, 10-decenas1-1, 10).sum();
				
		//llevada centenas
		//+1
		int centenas1 = random.ints(1, 1, 10).sum();
		int centenas2 = 1;
		if(centenas1<9)
		  centenas2 = random.ints(1, 10-centenas1-1, 10).sum();
		
		digitosOperador1.add(unidades1);
		digitosOperador1.add(decenas1);
		digitosOperador1.add(centenas1);
		
		digitosOperador2.add(unidades2);
		digitosOperador2.add(decenas2);
		digitosOperador2.add(centenas2);
		
		int operador1 = 0;
		int operador2 = 0;
		for(int i=0; i<digitosOperador1.size();i++)
			operador1+=Math.pow(10,i) * digitosOperador1.get(i);
		for(int i=0; i<digitosOperador2.size();i++)
			operador2+=Math.pow(10,i) * digitosOperador2.get(i);
		Suma suma = new Suma();
		suma.setOperando1(operador1);
		suma.setOperando2(operador2);
		suma.setResultadoSuma(operador1+operador2);
		
		if (sumasNivel.contains(suma)){
			colisiones++;
			if(colisiones<=maxColisiones) {
				suma = getOperandosNivel26(sumasNivel,colisiones, maxColisiones);
				return suma;
			} else {
				System.out.println("MAXIMO NUMERO COLISIONES PRODUCIDAS: "+suma);
				return suma;
			}
		} else {
			return suma;
		}
	}

	

}
