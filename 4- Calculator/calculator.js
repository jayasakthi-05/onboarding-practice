const display = document.getElementById("display");
const buttons = document.querySelectorAll("button");

let currentNumber = "";
let previousNumber = "";
let operator = null;
let resetScreen = false;
let errorState = false;

buttons.forEach(button => {

    button.addEventListener("click", () => {

        const value = button.textContent;

        if (!isNaN(value)) {
            inputNumber(value);
        }

        else if (value === ".") {
            inputDecimal();
        }

        else if (["+", "-", "*", "/"].includes(value)) {
            chooseOperator(value);
        }

        else if (value === "=") {
            calculate();
        }

        else if (value === "C") {
            clearCalculator();
        }

    });

});


function inputNumber(number) {

     if (errorState) return;

    if (resetScreen) {
        currentNumber = "";
        resetScreen = false;
    }

    if (currentNumber === "0") {
        currentNumber = number;
    } else {
        currentNumber += number;
    }

    updateDisplay();
}

function updateDisplay() {
    display.value = currentNumber || "0";
}

function inputDecimal() {

      if (errorState) return;

    if (!currentNumber.includes(".")) {
        currentNumber += ".";
    }

    updateDisplay();
}


function chooseOperator(op) {

    if (errorState) return;

    if (resetScreen) {
        operator = op;
        return;
    }

    if (currentNumber === "") return;

    if (previousNumber !== "") {
        calculate();
    }

    operator = op;
    previousNumber = currentNumber;
    resetScreen = true;
}


function calculate() {

    let result;

    let firstNumber = Number(previousNumber);
    let secondNumber = Number(currentNumber);

    if (operator === "+") {
        result = firstNumber + secondNumber;
    }

    else if (operator === "-") {
        result = firstNumber - secondNumber;
    }

    else if (operator === "*") {
        result = firstNumber * secondNumber;
    }

    else if (operator === "/") {

        if (secondNumber === 0) {
            display.value = "Error";
            errorState = true;
            return;
        }

        result = firstNumber / secondNumber;
    }


    currentNumber = result;
    previousNumber = "";
    operator = null;
    resetScreen = true;

    updateDisplay();
}


function clearCalculator() {

    currentNumber = "";
    previousNumber = "";
    operator = null;
    resetScreen = false;
    errorState = false;

    updateDisplay();
}