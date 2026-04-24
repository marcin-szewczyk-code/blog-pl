---
title: "STM32: LED i przycisk – wejście/wyjście GPIO w trybie blokującym"
description: "Konfiguracja wejścia i wyjścia GPIO w STM32 oraz sterowanie diodą LED przyciskiem w trybie blokującym (polling) z użyciem STM32CubeIDE i CubeMX."
date: 2026-04-27 07:00:00 +0100
categories: [Systemy wbudowane, STM32]
tags: [stm32, gpio]
---

Pierwszym krokiem w pracy z mikrokontrolerem STM32 jest obsługa wejść i wyjść GPIO (ang. *General-Purpose Input/Output*).

Najprostszym przykładem jest sterowanie diodą LED przy użyciu przycisku. Można w tym celu najpierw wykorzystać diodę na płytce, a następnie wykonać własne połączenia GPIO.

Stanowi to podstawowy workflow: połączenia sprzętowe, konfiguracja w CubeMX oraz kod w CubeIDE.

Pierwszy kod wygodnie jest zacząć pisać w pętli głównej `while (1)`. W tym podejściu odczytywanie stanu wejścia odbywa się w trybie ciągłym (*polling*), a dodatkowo stosowane funkcje opóźniające (`HAL_Delay`) blokują wykonywanie CPU (*blocking mode*).

W tym wpisie wykorzystana jest płytka NUCLEO-G431KB ([dokumentacja techniczna i pinout](/assets/posts/stm32-led-button-gpio-blocking-mode/um2397-stm32g4-nucleo32-board-mb1430-stmicroelectronics.pdf)).

Poniżej znajduje się film YouTube pokazujący cały proces krok po kroku, a dalej pokazane są poszczególne etapy.


---

## Wideo

Poniżej pełny proces konfiguracji układu – krok po kroku, bez narracji:

<iframe width="100%" height="500" src="https://www.youtube.com/embed/ZItn5qJscc0" 
title="STM32 GPIO LED Button" 
frameborder="0" 
allowfullscreen></iframe>

## Założenia układu

Układ składa się z dwóch części:

- dioda (czerwona) sterowana przyciskiem ręcznie (bez mikrokontrolera),
- dioda wbudowana (zielona) sterowana przez mikrokontroler oraz dioda zewnętrzna (żółta) sterowana przez mikrokontroler za pomocą przycisku.

W pierwszej części LED sterowana jest bezpośrednio przez przycisk, bez udziału mikrokontrolera.

W drugiej części najpierw wykorzystana jest dioda (zielona) znajdująca się na płytce STM.

Następnie pokazane jest sterowanie diodą zewnętrzną z poziomu MCU (ang. *Microcontroller Unit*), w tym pokazana jest konfiguracja wejścia i wyjścia GPIO.

Układ realizuje mechanizm sterowania w dwóch wariantach: sprzętowym (bez MCU) oraz programowym (z MCU).

---

## Oprogramowanie

Należy zainstalować dwa programy:
- STM32CubeMX (STM32Cube initialization code generator) – konfiguracja (piny, zegary, peryferia) → [https://www.st.com/en/development-tools/stm32cubemx.html](https://www.st.com/en/development-tools/stm32cubemx.html)
- STM32CubeIDE (Integrated Development Environment for STM32) – kod, kompilacja, wgrywanie → [https://www.st.com/en/development-tools/stm32cubeide.html](https://www.st.com/en/development-tools/stm32cubeide.html)

CubeMX generuje kod inicjalizacyjny, który jest dalej rozwijany w CubeIDE.

Z CubeIDE wykonywany jest build i wgranie (flash) programu do mikrokontrolera.

---

## Schemat połączeń (opisowy)

Układ połączony jest na płytce stykowej (breadboard).

### 1. Zasilanie

Zasilanie 5 V z osobnego USB (poza płytką Nucleo) podawane jest na szynę dodatnią (+) breadboardu, a następnie doprowadzane do pinów Vin–GND mikrokontrolera.

Pin 3V3 podłączony jest do drugiej szyny dodatniej (+) breadboardu, a pin GND do szyny masy (−).

Napięcie 3V3 służy do zasilania elementów układu podłączonych do MCU (peryferiów, ang. *peripherals*) oraz jako napięcie odniesienia dla logiki wejść GPIO (stan wysoki), realizowane przez rezystory pull-up.

Zasilenie MCU przez Vin pozwala na jednoczesne zasilanie układu i jego programowanie przez USB.

Wszystkie części układu muszą mieć wspólną masę (GND). Brak wspólnej masy prowadzi do niestabilnego działania.

### 2. LED bez mikrokontrolera

Połączenie: 3V3 → rezystor → LED (czerwony) → przycisk → GND.

Pozwala to sprawdzić działanie LED i sposób sterowania przyciskiem bez MCU.

Rezystor ograniczający prąd może znajdować się przed lub za diodą – w obu przypadkach układ działa identycznie.

### 3. LED sterowana przez mikrokontroler

Dioda wbudowana (zielona) jest sterowana bezpośrednio z poziomu programu i wykorzystywana jako pierwszy test działania kodu.

### 4. LED sterowana przez GPIO_Output

Połączenie: pin PA0 → rezystor 330 Ω → LED (żółty) → GND.

Dioda sterowana jest przez mikrokontroler za pomocą przycisku.

### 5. Przycisk wejściowy (GPIO_Input)

Połączenie:
- pin PB6 → przycisk → GND
- pin PB6 → zewnętrzny rezystor pull-up 10 kΩ do 3V3

Wejście działa w logice *active low* (stan niski przy wciśnięciu przycisku).

Wciśnięcie przycisku oznacza stan niski, a jego zwolnienie – stan wysoki.

Zbyt mała wartość rezystora pull-up zwiększa pobór prądu.

---

## Konfiguracja w CubeMX

Poniżej minimalna konfiguracja:

- PA0 → GPIO_Output
- PB6 → GPIO_Input
- tryb wejścia: pull-up (zewnętrzny)

Kod inicjalizacyjny generowany jest w CubeMX i używany w CubeIDE.

Przed generacją kodu należy zaznaczyć `Toolchain / IDE` jako STM32CubeIDE.

Nazwy pinów (np. LED_GREEN, LED_YELLOW, BTN) można nadać w CubeMX i używać ich bezpośrednio w kodzie CubeIDE.

Wynik konfiguracji zapisywany jest w pliku `.ioc` (piny, peryferia, zegary). Plik ten jest używany przez CubeMX do ponownej generacji kodu. Na jego podstawie tworzone są pliki projektu, w tym `main.c`, w którym rozpoczyna się pisanie kodu.

---

## Praca w CubeIDE

Po wygenerowaniu projektu w CubeMX dalsza praca odbywa się w CubeIDE.

W CubeIDE otwierany jest projekt, edytowany kod źródłowy, a następnie wykonywana jest kompilacja (build) i wgranie programu (flash) do mikrokontrolera.

Kod użytkownika należy umieszczać pomiędzy znacznikami `USER CODE BEGIN` oraz `USER CODE END`. Pozwala to zachować własne fragmenty kodu po ponownej generacji plików z CubeMX. Pozostałe fragmenty kodu są generowane automatycznie przez CubeMX.

Programowanie płytki odbywa się przez USB z użyciem wbudowanego interfejsu ST-Link.

Po zbudowaniu projektu (Build) kod można wgrać do mikrokontrolera (Run – bez debugowania, Debug – z możliwością śledzenia kodu) i od razu sprawdzić działanie układu.

---

## Kilka wariantów kodu do przećwiczenia

### Kod #1 – ustawienie stanu wyjścia GPIO

Najprostszy kod można umieścić w pętli głównej `while (1)`.

Kod pisany jest w języku `C`.

Pierwszy przykład dotyczy sterowania diodą zieloną znajdującą się na płytce Nucleo.

W tym wariancie mikrokontroler ustawia stan wysoki na pinie sterującym diodą LED. Dioda świeci ciągle.

``` c
  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {

    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */

    // Set LED pin HIGH (LED ON)
	HAL_GPIO_WritePin(LED_GREEN_GPIO_Port, LED_GREEN_Pin, GPIO_PIN_SET);


  }
  /* USER CODE END 3 */
```

Linia:

``` c
HAL_GPIO_WritePin(LED_GREEN_GPIO_Port, LED_GREEN_Pin, GPIO_PIN_SET);
```

ustawia stan wysoki na pinie LED. W efekcie dioda LED pozostaje włączona.

### Kod #2 – miganie LED (blocking)

Drugi kod rozszerza poprzedni przykład o miganie diodą LED.

Dioda jest cyklicznie włączana i wyłączana z użyciem funkcji opóźniającej `HAL_Delay()`.

``` c
  while (1)
  {

	// Turn LED ON for 750 ms
    HAL_GPIO_WritePin(LED_GREEN_GPIO_Port, LED_GREEN_Pin, GPIO_PIN_SET);
	HAL_Delay(750);

    // Turn LED OFF for 500 ms,  set LED pin LOW (LED OFF)
    HAL_GPIO_WritePin(LED_GREEN_GPIO_Port, LED_GREEN_Pin, GPIO_PIN_RESET);
	HAL_Delay(500);

  }
```

Działanie:

- LED włączona przez 750 ms,
- LED wyłączona przez 500 ms,
- cykl powtarzany w nieskończonej pętli.

Funkcja:

``` c
HAL_Delay(time_ms);
```

zatrzymuje wykonywanie programu na określony czas (w milisekundach). W tym czasie CPU nie wykonuje żadnych innych zadań.

Podejście to jest przykładem trybu blokującego (*blocking mode*), ponieważ w trakcie opóźnienia mikrokontroler nie reaguje na zdarzenia zewnętrzne (np. przycisk).

### Kod #3 – sterowanie LED przyciskiem (polling)

Trzeci kod rozszerza poprzedni przykład o odczyt stanu wejścia GPIO i sterowanie wyjściem.

Stan przycisku jest cyklicznie odczytywany w pętli `while (1)` – jest to podejście typu *polling*.

``` c
  // Turn external LED ON once before entering the loop
  HAL_GPIO_WritePin(LED_YELLOW_GPIO_Port, LED_YELLOW_Pin, GPIO_PIN_SET);

  while (1)
  {

	  HAL_GPIO_WritePin(LED_GREEN_GPIO_Port, LED_GREEN_Pin, GPIO_PIN_SET);
	  HAL_Delay(750);
	  HAL_GPIO_WritePin(LED_GREEN_GPIO_Port, LED_GREEN_Pin, GPIO_PIN_RESET);
	  HAL_Delay(500);

      // Read button state (active LOW)
      if (HAL_GPIO_ReadPin(BTN_GPIO_Port, BTN_Pin) == GPIO_PIN_RESET)
      {
          // Button pressed -> LED ON
          HAL_GPIO_WritePin(LED_YELLOW_GPIO_Port, LED_YELLOW_Pin, GPIO_PIN_SET);
      }
      else
      {
          // Button released -> LED OFF
          HAL_GPIO_WritePin(LED_YELLOW_GPIO_Port, LED_YELLOW_Pin, GPIO_PIN_RESET);
      }

  }
```

Działanie układu:
- przycisk nie wciśnięty → stan wysoki → LED wyłączona
- przycisk wciśnięty → stan niski → LED włączona

Jest to bezpośrednie odwzorowanie stanu wejścia na wyjście.

Stan przycisku sprawdzany jest tylko raz na iterację pętli. Zastosowanie `HAL_Delay()` powoduje, że reakcja na przycisk jest opóźniona – mikrokontroler odczytuje wejście dopiero po zakończeniu opóźnień.

### Kod #4 – przełączanie LED przyciskiem (toggle)

Kolejny kod pokazuje sterowanie diodą z użyciem prostej logiki zaimplementowanej w MCU.

W tym wariancie naciśnięcie przycisku nie tylko odwzorowuje stan wejścia na wyjście, ale zmienia zapamiętany stan diody LED.

```c
  /* USER CODE BEGIN WHILE */

  // Turn internal LED ON once before entering the loop
  HAL_GPIO_WritePin(LED_GREEN_GPIO_Port, LED_GREEN_Pin, GPIO_PIN_SET);

  // Turn external LED ON once before entering the loop
  HAL_GPIO_WritePin(LED_YELLOW_GPIO_Port, LED_YELLOW_Pin, GPIO_PIN_SET);

  // Toggle state variables
  uint8_t ledState = 1;
  uint8_t lastButtonState = GPIO_PIN_SET;  // pull-up -> default HIGH

  while (1)
  {

    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
	  // Read current button state
	  uint8_t currentButtonState = HAL_GPIO_ReadPin(BTN_GPIO_Port, BTN_Pin);

	  // Detect button press (falling edge: HIGH -> LOW)
	  if (lastButtonState == GPIO_PIN_SET && currentButtonState == GPIO_PIN_RESET)
	  {
	    HAL_Delay(20);  // simple debounce

	    if (HAL_GPIO_ReadPin(BTN_GPIO_Port, BTN_Pin) == GPIO_PIN_RESET)
	    {
	      // Toggle LED
	      ledState = !ledState;

	      if (ledState)
	      {
	        HAL_GPIO_WritePin(LED_YELLOW_GPIO_Port, LED_YELLOW_Pin, GPIO_PIN_SET);
	      }
	      else
	      {
	        HAL_GPIO_WritePin(LED_YELLOW_GPIO_Port, LED_YELLOW_Pin, GPIO_PIN_RESET);
	      }
	    }
	  }

	  // Update previous button state
	  lastButtonState = currentButtonState;

  }
  /* USER CODE END 3 */
  ```

Działanie układu – toggle:

- LED początkowo włączona,
- pierwsze naciśnięcie przycisku → wyłączenie LED,
- kolejne naciśnięcie → włączenie LED,
- każde następne naciśnięcie zmienia stan LED na przeciwny.

Krótki `HAL_Delay(20)` pełni rolę prostego programowego *debounce*, czyli ogranicza wpływ drgań styków przycisku.

Wykrywanie zbocza pozwala reagować tylko na zmianę stanu przycisku, a nie na jego ciągłe przytrzymanie.

---

## Podsumowanie

Sterowanie LED przyciskiem to najprostszy przykład pracy z GPIO w STM32 (*hello-world* dla MCU).

Pozwala przećwiczyć workflow: od połączeń sprzętowych do kodu.

Tryb blokujący (z użyciem `HAL_Delay`) jest najprostszy do uruchomienia MCU, ale ma ograniczenia wynikające z blokowania CPU.

Stanowi punkt wyjścia do dalszych kroków: przerwań, timerów i trybów niskiego poboru mocy oraz PWM.

Kolejnym krokiem jest przejście do obsługi wejść z użyciem przerwań (EXTI).
