// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FlorenCoin {
    string public name = "FlorenCoin";  // Nombre del token
    string public symbol = "FLOREN";    // Símbolo del token
    uint8 public decimals = 18;         // Decimales del token
    uint256 public totalSupply;         // Total de tokens en circulación

    mapping(address => uint256) public balanceOf;  // Mapeo de saldos de las direcciones
    mapping(address => mapping(address => uint256)) public allowance; // Mapeo de allowances

    // Definir eventos
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Constructor que asigna la cantidad inicial de tokens al creador (msg.sender)
    constructor() {
        totalSupply = 1000000 * 10 ** uint256(decimals); // 1 millón de tokens
        balanceOf[msg.sender] = totalSupply;  // El propietario inicial recibe todos los tokens
        emit Transfer(address(0), msg.sender, totalSupply);  // Emitir el evento de transferencia inicial
    }

    // Función para transferir tokens
    function transfer(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "Cannot transfer to the zero address");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    // Función para aprobar una cantidad de tokens a un tercero
    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // Función para transferir tokens desde una dirección aprobada
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        require(from != address(0), "Cannot transfer from the zero address");
        require(to != address(0), "Cannot transfer to the zero address");
        require(balanceOf[from] >= amount, "Insufficient balance");
        require(allowance[from][msg.sender] >= amount, "Allowance exceeded");

        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        allowance[from][msg.sender] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }
}
