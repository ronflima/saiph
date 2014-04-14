# Saiph Library for iOS

This library contains free implementations of common algorithms used for check 
digits in banking area. Basic algorithms to create IBAN numbers, brazilian CPF 
validation and other algorithms are implemented through a simple, yet powerful, 
interface.

The implementations are fully written in Objective C, fully object-oriented.

# Usage

Include the Saiph.h header to your source code and link it against libSaiph.a
binary. All the sources are documented using doxygen.

# What is Saiph, anyways?
Saiph is the arabic word for "sword".

# Algorithms
## ISO7064 - Modulus 97 simplified

The implementation of Modulus 97 algorithm follows a simplified model, as 
described below.

1. In order to calculate the check digits for a given number _n_, suffix this 
number with two zeroes.
2. Divide the resulting number _N_ and save the remainder _r_.
3. Calculate the check number _C_ by the subtracting _r_ from 98. 

To check if the algorithm is working, append the check number _C_ to the 
original number _n_ and divide the result by 97. If the remainder is 1, the 
check digit was successfully calculated.

This method is used to calculate the check digit within the IBAN number for 
internation bank accounts.

## CNJ Validation

CNJ stands for _Conselho Nacional de Justiça_ which centralized and standardized a unique identification for
lawsuits in Brazil. CNJ is validated according to the document "Resolução nº 65 de 16 de Dezembro de 2008", where all
the formation law and algorithms for validation of the CNJ number are defined.