// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Slymaster {
  // On définit le nom et le symbole du token
  string public name = "Slymaster";
  string public symbol = "SLY";

  // On définit le nombre de décimales du token
  uint8 public decimals = 8;

  // On définit la quantité totale de tokens
  uint256 public totalSupply;

  // On stocke l'adresse du créateur du contrat
  address public creator;

  // On stocke les balances des différents comptes
  mapping(address => uint256) public balances;

  // On déclare la variable generateTokens en utilisant le type uint256
  uint256 public generateTokens;

  // On crée le constructeur du contrat
  constructor() {
    // On stocke l'adresse du créateur du contrat
    creator = msg.sender;

    // On génère suffisamment de SLY pour le créateur du contrat
    totalSupply = 100000 * (10 ** uint256(decimals));
    balances[creator] = totalSupply;

    // On déclare la variable generateTokens en utilisant le type uint256
    generateTokens = block.timestamp + 1 hours;
  }

  // On définit une fonction pour transférer des tokens d'un compte à un autre
  function transfer(address _to, uint256 _value) public {
    // On vérifie que l'adresse qui appelle la fonction a suffisamment de tokens pour transférer la valeur demandée
    require(balances[msg.sender] >= _value, "Not enough balance");

    // On met à jour la balance de l'adresse qui appelle la fonction
    balances[msg.sender] -= _value;

    // On met à jour la balance de l'adresse de destination
    balances[_to] += _value;
  }

  // On définit une fonction pour brûler des tokens
  function burn(uint256 _value) public {
    // On vérifie que l'adresse qui appelle la fonction a suffisamment de tokens pour brûler la valeur demandée
    require(balances[msg.sender] >= _value, "Not enough balance");

    // On met à jour la balance de l'adresse qui appelle la fonction
    balances[msg.sender] -= _value;

    // On met à jour la quantité totale de tokens
    totalSupply -= _value;
  }

  // On définit une fonction pour générer des tokens régulièrement
  function generate() public {
    // On génère un petit nombre de tokens pour le créateur du contrat
    totalSupply += 1000 * (10 ** uint256(decimals));
    balances[creator] += 1000 * (10 ** uint256(decimals));

    // On met à jour la variable generateTokens avec la prochaine heure
    generateTokens = block.timestamp + 1 hours;
  }
}
