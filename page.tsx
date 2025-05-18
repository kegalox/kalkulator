'use client';

import React, { useState, useEffect } from 'react';

// Предположим, у вас есть функция convert и объект conversionFactors
// Например:
const conversionFactors = {
  length: {
    Meter: 1,
    Kilometer: 0.001,
    // добавьте остальные единицы
  },
  weight: {
    Gram: 1,
    Kilogram: 0.001,
  },
  temperature: {
    Celsius: 1,
    Fahrenheit: 1, // пример, потребуется особая обработка
  },
};

// Функция конвертации (пример)
function convert(value, fromUnit, toUnit, category) {
  if (category === 'temperature') {
    if (fromUnit === 'Celsius' && toUnit === 'Fahrenheit') {
      return value * 9/5 + 32;
    } else if (fromUnit === 'Fahrenheit' && toUnit === 'Celsius') {
      return (value - 32) * 5/9;
    } else {
      return value; // если одинаковые
    }
  } else {
    // для length и weight
    const fromFactor = conversionFactors[category][fromUnit];
    const toFactor = conversionFactors[category][toUnit];
    return (value * fromFactor) / toFactor;
  }
}

export default function Page() {
  const [value, setValue] = useState(0);
  const [category, setCategory] = useState('length');

  const defaultUnits = {
    length: { from: 'Meter', to: 'Kilometer' },
    weight: { from: 'Gram', to: 'Kilogram' },
    temperature: { from: 'Celsius', to: 'Fahrenheit' },
  };

  const [fromUnit, setFromUnit] = useState(defaultUnits[category].from);
  const [toUnit, setToUnit] = useState(defaultUnits[category].to);
  const [result, setResult] = useState<number | null>(null);

  useEffect(() => {
    setFromUnit(defaultUnits[category].from);
    setToUnit(defaultUnits[category].to);
  }, [category]);

  const handleConvert = () => {
    const converted = convert(value, fromUnit, toUnit, category);
    setResult(converted);
  };

  return (
    <div style={{ padding: '20px', fontFamily: 'Arial' }}>
      <h1>Конвертер единиц</h1>

      {/* Категория */}
      <label>
        Категория:
        <select
          value={category}
          onChange={(e) => setCategory(e.target.value)}
        >
          <option value="length">Длина</option>
          <option value="weight">Вес</option>
          <option value="temperature">Температура</option>
        </select>
      </label>

      {/* Ввод значения */}
      <div style={{ marginTop: '10px' }}>
        <input
          type="number"
          value={value}
          onChange={(e) => setValue(parseFloat(e.target.value))}
        />
      </div>

      {/* Выбор единиц измерения */}
      <div style={{ marginTop: '10px' }}>
        <label>
          Из:
          <select
            value={fromUnit}
            onChange={(e) => setFromUnit(e.target.value)}
          >
            {Object.keys(conversionFactors[category]).map((unit) => (
              <option key={unit} value={unit}>{unit}</option>
            ))}
          </select>
        </label>
        <label style={{ marginLeft: '10px' }}>
          В:
          <select
            value={toUnit}
            onChange={(e) => setToUnit(e.target.value)}
          >
            {Object.keys(conversionFactors[category]).map((unit) => (
              <option key={unit} value={unit}>{unit}</option>
            ))}
          </select>
        </label>
      </div>

      {/* Кнопка конвертации */}
      <div style={{ marginTop: '10px' }}>
        <button onClick={handleConvert}>Конвертировать</button>
      </div>

      {/* Результат */}
      {result !== null && (
        <div style={{ marginTop: '20px' }}>
          <h2>Результат: {result}</h2>
        </div>
      )}
    </div>
  );
}