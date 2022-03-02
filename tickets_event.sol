// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.1;

contract Tickets {
    
    uint    disponibles;
    uint256 precio; // WEIs

    constructor (uint _disponibles, uint256 _precio) { // Clonar
        disponibles = _disponibles;
        precio      = _precio;
    }

    function getDisponibles() public view returns (uint) {
        return (disponibles);
    }

    function comprar(uint _cantidad) public payable {
        require(disponibles > 0, "Entradas agotadas");
        require(disponibles >= _cantidad, "No hay tantas entradas disponibles");
        require(msg.value == precio, "Importe no coincide con el precio");
        disponibles = disponibles - _cantidad;
    }
}