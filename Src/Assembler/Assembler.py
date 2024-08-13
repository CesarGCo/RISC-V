import sys

# A função abaixo converte a variável "decimal" para bináro em complemento de 2, 
# a variável "maxSize" indica o número de bits que o número será convertido
def ConvertBin(decimal, maxSize):
    aux = ''
    if(decimal < 0):
        aux = bin(decimal + 1)[3:]
        tamanho = len(aux)
        if(tamanho < maxSize):
            for i in range(0, (maxSize - tamanho)):
                aux = '0'+ aux
        aux = list(aux)
        for i in range(0, maxSize):
            if(aux[i] == '0'):
                aux[i] = '1'
            elif(aux[i] == '1'):
                aux[i] = '0'
    elif(decimal >= 0):
        aux = bin(decimal)[2:]
        tamanho = len(aux)
        if(tamanho < maxSize):
            for i in range(0, (maxSize - tamanho)):
                aux = '0' + aux
    return (''.join(aux)) 
 
def ConvertInMAchineCode(opr, arquivo, escrevearquivo):
    #A sequência de "IFs" abaixo seleciona o tipo de instrução que será transformada em linguagem de máquina
    #A função Convert é utilizada para converter o número do registrador, o valor imediato ou o endereço de decimal para binário
    #A escrita de cada instrução em linguagem de máquina vai depender do tipo de instrução a que ela pertence. Ex add->Tipo-R, addi->Tipo-I e assim para todas as instruções
    
    
    if(opr == "add"):
        funct7 = "0000000"
        rs2 = ConvertBin(int(assembly[indice][3][1:]), 5)
        rs1 = ConvertBin(int(assembly[indice][2][1:]), 5)
        funct3 = "000"
        rd = ConvertBin(int(assembly[indice][1][1:]), 5)
        opcode = "0110011"
        if(escrevearquivo == True):
            arquivo.write(funct7 + rs2 + rs1 + funct3 + rd + opcode + '\n')
        else:
            print(funct7 + rs2 + rs1 + funct3 + rd + opcode)
        
    elif(opr == "addi"):
        imm = ConvertBin(int(assembly[indice][3][0:]), 12)
        rs1 = ConvertBin(int(assembly[indice][2][1:]), 5)
        funct3 = "000"
        rd = ConvertBin(int(assembly[indice][1][1:]), 5)
        opcode = "0010011"
        if(escrevearquivo == True):
            arquivo.write(imm + rs1 + funct3 + rd + opcode + '\n')
        else:
            print(imm + rs1 + funct3 + rd + opcode)
    
    elif(opr == "lw"):
        imm = ConvertBin(int(assembly[indice][2][0:]), 12)
        rs1 = ConvertBin(int(assembly[indice][3][1:]), 5)
        funct3 = "010" 
        rd = ConvertBin(int(assembly[indice][1][1:]), 5)
        opcode = "0000011"
        if(escrevearquivo == True):
            arquivo.write(imm + rs1 + funct3 + rd + opcode + '\n')
        else:
            print(imm + rs1 + funct3 + rd + opcode)
        
    elif(opr == "sw"):
        aux = ConvertBin(int(assembly[indice][2][0:]),12)
        imm2 =  aux[7:12]
        rs2 = ConvertBin(int(assembly[indice][3][1:]), 5)                 
        rs1 = ConvertBin(int(assembly[indice][1][1:]), 5)
        funct3 = "010"
        imm1 = aux[0:7]   
        opcode = "0100011"
        if(escrevearquivo == True):
            arquivo.write(imm1 + rs1 + rs2 + funct3 + imm2 + opcode + '\n')
        else:
            print(imm1 + rs1 + rs2 + funct3 + imm2 + opcode)
        
    elif(opr == "bne"):
        aux = ConvertBin(int(assembly[indice][3][0:]), 12)
        imm1 = aux[0]
        imm2 = aux[2:8]
        rs1 = ConvertBin(int(assembly[indice][1][1:]), 5) 
        rs2 = ConvertBin(int(assembly[indice][2][1:]), 5)
        funct3 = "001"  
        imm3 = aux[8:12]
        imm4 = aux[1]
        opcode = "1100111"
        if(escrevearquivo == True):
            arquivo.write(imm1 + imm2 + rs2 + rs1 + funct3 + imm3 + imm4 + opcode + '\n')
        else:
            print(imm1 + imm2 + rs2 + rs1 + funct3 + imm3 + imm4 + opcode)
    
    elif(opr == "xor"):
        funct7 = "0000000"
        rs2 = ConvertBin(int(assembly[indice][3][1:]), 5)
        rs1 = ConvertBin(int(assembly[indice][2][1:]), 5)
        funct3 = "100"
        rd = ConvertBin(int(assembly[indice][1][1:]), 5)
        opcode = "0110011"
        if(escrevearquivo == True):
            arquivo.write(funct7 + rs2 + rs1  + funct3  + rd + opcode + '\n')
        else:
            print(funct7 + rs2 + rs1  + funct3  + rd + opcode)
    
    elif(opr == "sll"):
        funct7 = "0000000"
        rs2 = ConvertBin(int(assembly[indice][3][1:]), 5)
        rs1 = ConvertBin(int(assembly[indice][2][1:]), 5)
        funct3 = "001"
        rd = ConvertBin(int(assembly[indice][1][1:]), 5)
        opcode = "0110011"  
        if(escrevearquivo == True):
            arquivo.write(funct7 + rs2 + rs1 + funct3 + rd + opcode + '\n')
        else:
            print(funct7 + rs2 + rs1 + funct3 + rd + opcode)


entrada = sys.argv[1]
escreve_arquivo = False
saida = ""
arquivo = ""
if(len(sys.argv) == 4 and sys.argv[2] == "-o"):
    escreve_arquivo = True
    saida = sys.argv[3]


#Leitura do Arquivo:  
with open(entrada, 'r') as file:
    # A variável "assembly" é um vetor que irá receber todas as instruções do código, 
    # sendo que cada indice do vetor é uma instrução no formato de string
    assembly = file.readlines()
    if(escreve_arquivo == True):
        arquivo = open(saida, 'w')
    # Abaixo é utilizado um for juntamente a função "enumerate" para extrair o elemno em determinada posição do vetor juntamente com seu índice
    for indice, instruction in enumerate(assembly):
        # Abaixo a o  indice x do vetor será tratado de forma a remover as "," "\n" "(" e ")",
        # e onde houver espaços em branco será separado de forma que cada partição da instrução será colocada em um índice do vetor
        assembly[indice] = instruction.replace(',', '').replace('\n', '').replace('(', ' ').replace(')', '').split(' ')
        operate = assembly[indice][0]
        ConvertInMAchineCode(operate, arquivo, escreve_arquivo)
        



            

