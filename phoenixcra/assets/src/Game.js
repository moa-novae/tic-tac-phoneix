import React, { useState, useEffect } from "react";
import axios from "axios";
import Board from "./Board";
export default function Game(props) {
  const initialState = {
    id: null,
    history: [Array(9).fill(null)],
    stepNumber: 0,
    xIsNext: true,
  };
  const [gameState, setGameState] = useState(initialState);
  useEffect(() => {
    axios.get("/api/game").then((g) => {
      setGameState({
        id: g.data.data[0].id,
        history: g.data.data[0].history,
        xIsNext: g.data.data[0].xIsNext,
        stepNumber: g.data.data[0].history.length - 1,
      });
    });
  }, []);

  function handleSquareClick(i) {
    let newState;
    setGameState((prev) => {
      const history = prev.history.slice(0, prev.stepNumber + 1);
      const current = history[history.length - 1];
      const squares = current.slice();
      if (calculateWinner(squares) || squares[i]) {
        return prev;
      }
      squares[i] = prev.xIsNext ? "X" : "O";
      newState = {
        id: prev.id,
        history: history.concat([squares]),
        stepNumber: history.length,
        xIsNext: !prev.xIsNext,
      };
      axios.put(`/api/game/${gameState.id}`, {
        game: {
          history: newState.history,
          xIsNext: newState.xIsNext,
        },
      });
      return newState;
    });
  }

  function handleGameCreation() {
    setGameState(initialState);
    axios.put(`/api/game/${gameState.id}`, {
      game: {
        history: initialState.history,
        xIsNext: initialState.xIsNext,
      },
    });
  }

  function jumpTo(step) {
    setGameState((prev) => ({
      ...prev,
      stepNumber: step,
      xIsNext: step % 2 === 0,
    }));
  }

  const history = gameState.history;

  const current = history[gameState.stepNumber];
  const winner = calculateWinner(current);

  const moves = history.map((step, move) => {
    const desc = move ? "Go to move #" + move : "Go to game start";
    return (
      <li key={move}>
        <button onClick={() => jumpTo(move)}>{desc}</button>
      </li>
    );
  });

  let status;
  if (winner) {
    status = "Winner: " + winner;
  } else {
    status = "Next player: " + (gameState.xIsNext ? "X" : "O");
  }

  return (
    <div className="game">
      <div className="game-board">
        <Board squares={current} onClick={(i) => handleSquareClick(i)} />
      </div>
      <div className="game-info">
        <div>{status}</div>
        <ol>{moves}</ol>
      </div>
      <div className="game-menu">
        <button onClick={() => handleGameCreation()}>New game</button>
      </div>
    </div>
  );
}
function calculateWinner(squares) {
  const lines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];
  // check draw
  if (squares.filter((square) => square).length === 9) {
    return "None...It's a draw";
  }
  for (let i = 0; i < lines.length; i++) {
    const [a, b, c] = lines[i];
    if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
      return squares[a];
    }
  }
  return null;
}
