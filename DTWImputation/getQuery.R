getQuery <- function(dataWithMissing, window_Size){
  
  #procurar missing values (neste caso o 1� que encontrar)
  #considerar tamanho da janela para a procura
  #casos: 1� o missing value encontra-se entre o in�cio dos dados e o tamanho da janela
  #       2� o missing value encontra-se no meio dos dados
  #       3� o missing value encontra-se no fim dos dados (situa��o semelhante � 1�)
  #       4� o missing value tem missings � volta (reduzir tamanho da janela? / tentar apanhar uma janela que funcione para os 2?)
  
  #verificar se o tamanho da janela inserida n�o � maior que os dados
  
  if(length(dataWithMissing) <= window_Size){stop("The size of the window is too big for the size of the data")}
 
  if(anyNA(dataWithMissing)){}else{stop("There are no missing values in this array")}
  
  missings= which(is.na(dataWithMissing))
  first_Missing= min(missings)
  
  range_Left= first_Missing-1;
  if(window_Size <= range_Left){range_Left= window_Size}
  
  range_Right= length(dataWithMissing) - first_Missing
  if(window_Size <= range_Right){range_Right= window_Size}
  

  #atr�s n�o h� missing values, apenas � frente do missing value encontrado
  if(range_Right>0){
    
    window_Right= (first_Missing+1):(first_Missing+range_Right)
    if(anyNA(dataWithMissing[window_Right])){
      
      range_Right= min(which(is.na(dataWithMissing[window_Right]))) - 1
      
    }
    
  }
  
  if((range_Right + range_Left)<window_Size){
    
    stop(paste("There is no usable window for searching the missing value, consider using a window size of", toString(range_Right + range_Left)), sep=" ")
    
  }else{
    
    return(list("range_Left" = range_Left, "range_Right" = range_Right, "firstMissingPosition"= first_Missing))  
    
    }
    
}