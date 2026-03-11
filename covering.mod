/*********************************************
 * OPL 22.1.1.0 Model
 * Author: dalvan
 * Creation Date: 20 de jun de 2024 at 08:51:47
 *********************************************/
 
 execute TIMELIMITE {
  cplex.tilim = 86400;
}

float tempInicial;
execute{
	var before = new Date();
	tempInicial = before.getTime();
}

// Parâmetros
int numArvores = ...; // Número de árvores
int numPatios = ...;  // Número total de pátios

range arvores = 0..numArvores-1;
range patios = 0..numPatios-1;

// Dados: vetor de possibilidades de pátios para cada árvore
{int} possiveisPatios[arvores] = ...; // conjunto de pátios possíveis para cada árvore
float volume[arvores] = ...;       // volume de cada árvore
float capacidade = ...;            // capacidade dos pátios

// Variáveis de decisão
dvar boolean x[arvores][patios]; // x[i][j] = 1 se a árvore i for arrastada para o pátio j
dvar boolean y[patios];          // y[j] = 1 se o pátio j for utilizado

// Função objetivo: Minimizar o número de pátios utilizados
minimize sum(j in patios) y[j];

// Restrições
subject to {
    // Cada árvore deve ser alocada a exatamente um dos pátios permitidos
    forall(i in arvores)
        sum(j in possiveisPatios[i]) x[i][j] == 1;

    // Relacionar o uso dos pátios à variável y
//    forall(j in patios)
//        y[j] >= sum(i in arvores: j in possiveisPatios[i]) x[i][j] / numArvores;
    forall(j in patios)
    	sum(i in arvores: j in possiveisPatios[i]) x[i][j] <= numArvores * y[j];

    // Restrição de capacidade: o volume total de árvores em cada pátio não pode exceder a capacidade
    forall(j in patios)
        sum(i in arvores: j in possiveisPatios[i]) volume[i] * x[i][j] <= capacidade;
}




execute{
	  var ofile = new IloOplOutputFile("ResultArvoresPatio.txt");
	  ofile.writeln("PROJETO TESE");
	  for(var p in thisOplModel.patios){
		  for (var a in thisOplModel.arvores) {
			  if(x[a][p]==1){    
			    	ofile.writeln("x["+a+"]["+p+"]="+thisOplModel.x[a][p]);
			  } 
  		}
	}
}
execute{
  var ofile = new IloOplOutputFile("ResultPatiosAbertos.txt");
  ofile.writeln("PROJETO TESE");
  for(var p in thisOplModel.patios){
	  if(y[p]==1){
		ofile.writeln("y["+p+"]="+thisOplModel.y[p]);
		} 
	}  
}  

execute{
  var ofile = new IloOplOutputFile("ResultFO.txt");
    ofile.writeln("Optimal objective value="+cplex.getObjValue());
//    ofile.writeln("Distancia de arraste total="+DistanciaTotal);
}

float tempFinal;
execute{
	var after = new Date();
	tempFinal = after.getTime();
}

float tempDeSolucao;
execute{
	var ofile = new IloOplOutputFile("ResultTempoSolucao.txt");
	tempDeSolucao = tempFinal-tempInicial;
	ofile.writeln("Tempo de Execução="+tempDeSolucao);
}


