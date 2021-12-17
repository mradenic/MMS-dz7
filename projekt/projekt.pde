import java.util.Collections;
import controlP5.*;
import processing.sound.*;
ControlP5 controlP5;

// specifications
int WIDTH_NUMBER = 7, HEIGHT_NUMBER = 13;
int SPACESIZE = 20;
int SCALE = 10;
int CARD_WIDTH = SCALE*9, CARD_HEIGHT = SCALE*12;
int FPS = 30;
int XMARGIN = (800 - WIDTH_NUMBER * (CARD_WIDTH + SPACESIZE) + SPACESIZE)/2;

// variables

Card spades_A, spades_2, spades_3, spades_4, spades_5, spades_6, spades_7, spades_8, spades_9, spades_10, spades_J, spades_Q, spades_K;
Card hearts_A, hearts_2, hearts_3, hearts_4, hearts_5, hearts_6, hearts_7, hearts_8, hearts_9, hearts_10, hearts_J, hearts_Q, hearts_K;
Card diamonds_A, diamonds_2, diamonds_3, diamonds_4, diamonds_5, diamonds_6, diamonds_7, diamonds_8, diamonds_9, diamonds_10, diamonds_J, diamonds_Q, diamonds_K;
Card clubs_A, clubs_2, clubs_3, clubs_4, clubs_5, clubs_6, clubs_7, clubs_8, clubs_9, clubs_10, clubs_J, clubs_Q, clubs_K;
Card back, back_blue, back_red,back_green;

Card[][] board = new Card[HEIGHT_NUMBER][WIDTH_NUMBER];
int[][] open = new int[HEIGHT_NUMBER][WIDTH_NUMBER];

Card[][] decks = new Card[13][4];
String[] suits = new String[4];

int Bodovi;
int Potezi;
int Sekunde, Razlika_sekundi, Minute, Razlika_minuta;
boolean ulovi = true, minuta_ulovi = true;

//karte u spilu (koji se nalazi u gornjem lijevom kutu) i jesu li otvorene
Card[] drawDeck = new Card[24];
int[] openDeck = new int[24];

ArrayList<Card> cardList = new ArrayList<Card>();
ArrayList<Card> cardListRem = new ArrayList<Card>();

Card draggedCard;
int draggedX, draggedY;
int beginningX, beginningY;
boolean dragging;

int beginning;

boolean startMenuEnabled, startAgain, endGame, restartGame, endChecked, fastEnd;
boolean endDeck, endField, isDeckOpened;
boolean entered, entered2;
int lengthDeck, lastFromDeck, previousFromDeck;

int drawEvery;
int nmbDraggedCards;

//karte koje se povlace, najvise 13 ih mozemo povuci te njihove X i Y koordinate
Card[] draggedCards = new Card[13];
int[] draggedXs = new int[13];
int[] draggedYs = new int[13];

RadioButton r, karta;

// glazba
SoundFile file, card_sound;
String audioName = "background.mp3";
String cardSoundName = "card_flip.mp3";
String path_backg, path_cards;

void setup(){
  size(800, 700);
  frameRate(FPS);
  background(#44B92C);
  cardList.clear();
  
  Bodovi = 0;
  Potezi = 0;
  Sekunde = second();
  
  //inicijalizacija Card objekata za svaku kartu
  spades_A = new Card("A_1", 1, "spades", "black"); cardList.add(spades_A);
  spades_2 = new Card("2_1", 2, "spades", "black"); cardList.add(spades_2);
  spades_3 = new Card("3_1", 3, "spades", "black"); cardList.add(spades_3);
  spades_4 = new Card("4_1", 4, "spades", "black"); cardList.add(spades_4);
  spades_5 = new Card("5_1", 5, "spades", "black"); cardList.add(spades_5);
  spades_6 = new Card("6_1", 6, "spades", "black"); cardList.add(spades_6);
  spades_7 = new Card("7_1", 7, "spades", "black"); cardList.add(spades_7);
  spades_8 = new Card("8_1", 8, "spades", "black"); cardList.add(spades_8);
  spades_9 = new Card("9_1", 9, "spades", "black"); cardList.add(spades_9);
  spades_10 = new Card("10_1", 10, "spades", "black"); cardList.add(spades_10);
  spades_J = new Card("J_1", 11, "spades", "black"); cardList.add(spades_J);
  spades_Q = new Card("Q_1", 12, "spades", "black"); cardList.add(spades_Q);
  spades_K = new Card("K_1", 13, "spades", "black"); cardList.add(spades_K);
  
  hearts_A = new Card("A_2", 1, "hearts", "red"); cardList.add(hearts_A);
  hearts_2 = new Card("2_2", 2, "hearts", "red"); cardList.add(hearts_2);
  hearts_3 = new Card("3_2", 3, "hearts", "red"); cardList.add(hearts_3);
  hearts_4 = new Card("4_2", 4, "hearts", "red"); cardList.add(hearts_4);
  hearts_5 = new Card("5_2", 5, "hearts", "red"); cardList.add(hearts_5);
  hearts_6 = new Card("6_2", 6, "hearts", "red"); cardList.add(hearts_6);
  hearts_7 = new Card("7_2", 7, "hearts", "red"); cardList.add(hearts_7);
  hearts_8 = new Card("8_2", 8, "hearts", "red"); cardList.add(hearts_8);
  hearts_9 = new Card("9_2", 9, "hearts", "red"); cardList.add(hearts_9);
  hearts_10 = new Card("10_2", 10, "hearts", "red"); cardList.add(hearts_10);
  hearts_J = new Card("J_2", 11, "hearts", "red"); cardList.add(hearts_J);
  hearts_Q = new Card("Q_2", 12, "hearts", "red"); cardList.add(hearts_Q);
  hearts_K = new Card("K_2", 13, "hearts", "red"); cardList.add(hearts_K);
  
  diamonds_A = new Card("A_3", 1, "diamonds", "red"); cardList.add(diamonds_A);
  diamonds_2 = new Card("2_3", 2, "diamonds", "red"); cardList.add(diamonds_2);
  diamonds_3 = new Card("3_3", 3, "diamonds", "red"); cardList.add(diamonds_3);
  diamonds_4 = new Card("4_3", 4, "diamonds", "red"); cardList.add(diamonds_4);
  diamonds_5 = new Card("5_3", 5, "diamonds", "red"); cardList.add(diamonds_5);
  diamonds_6 = new Card("6_3", 6, "diamonds", "red"); cardList.add(diamonds_6);
  diamonds_7 = new Card("7_3", 7, "diamonds", "red"); cardList.add(diamonds_7);
  diamonds_8 = new Card("8_3", 8, "diamonds", "red"); cardList.add(diamonds_8);
  diamonds_9 = new Card("9_3", 9, "diamonds", "red"); cardList.add(diamonds_9);
  diamonds_10 = new Card("10_3", 10, "diamonds", "red"); cardList.add(diamonds_10);
  diamonds_J = new Card("J_3", 11, "diamonds", "red"); cardList.add(diamonds_J);
  diamonds_Q = new Card("Q_3", 12, "diamonds", "red"); cardList.add(diamonds_Q);
  diamonds_K = new Card("K_3", 13, "diamonds", "red"); cardList.add(diamonds_K);
  
  clubs_A = new Card("A_4", 1, "clubs", "black"); cardList.add(clubs_A);
  clubs_2 = new Card("2_4", 2, "clubs", "black"); cardList.add(clubs_2);
  clubs_3 = new Card("3_4", 3, "clubs", "black"); cardList.add(clubs_3);
  clubs_4 = new Card("4_4", 4, "clubs", "black"); cardList.add(clubs_4);
  clubs_5 = new Card("5_4", 5, "clubs", "black"); cardList.add(clubs_5);
  clubs_6 = new Card("6_4", 6, "clubs", "black"); cardList.add(clubs_6);
  clubs_7 = new Card("7_4", 7, "clubs", "black"); cardList.add(clubs_7);
  clubs_8 = new Card("8_4", 8, "clubs", "black"); cardList.add(clubs_8);
  clubs_9 = new Card("9_4", 9, "clubs", "black"); cardList.add(clubs_9);
  clubs_10 = new Card("10_4", 10, "clubs", "black"); cardList.add(clubs_10);
  clubs_J = new Card("J_4", 11, "clubs", "black"); cardList.add(clubs_J);
  Card clubs_Q = new Card("Q_4", 12, "clubs", "black"); cardList.add(clubs_Q);
  clubs_K = new Card("K_4", 13, "clubs", "black"); cardList.add(clubs_K);
  
  back_blue = new Card("back", 0, "back", "blue");
  back_red = new Card("back2", 0, "back", "red");
  back_green = new Card("back3", 0, "back", "green");
  
  //postavljanje ploče i špilova na prazne
  for(int i = 0; i < HEIGHT_NUMBER; ++i)
  {
     for(int j = 0; j < WIDTH_NUMBER; ++j)
     {
        board[i][j] = null;
        open[i][j] = 0;
     }
  }
  
  for(int i = 0; i < 4; ++i)
    for(int j = 0; j < 13; ++j)
    {
      decks[j][i] = null;
    }
  
  //na početku ne postoje karte koje povlačimo
  for(int i = 0; i < 13; ++i)
  {
    draggedCards[i] = null;
    draggedXs[i] = 0;
    draggedYs[i] = 0;
  }
  
  draggedCard = null;
  dragging = false;
  
  //promiješamo karte prije nego ih postavimo na ploču
  Collections.shuffle(cardList);
  
  beginning = 1;
  
  startMenuEnabled = true;
  startAgain = false;
  lengthDeck = 0;
  lastFromDeck = 0;
  previousFromDeck = 0;
  drawEvery = 1;
  endDeck = false;
  endField = false;
  entered = false;
  entered2 = false;
  nmbDraggedCards = 0;
  endGame = false;
  isDeckOpened = false;
  restartGame = false;
  fastEnd = true;
  endChecked = false;
  
  //postavljanje radio buttona na početni ekran (za biranje otvaranja 1 ili 3 karte)
  controlP5 = new ControlP5(this);
  r = controlP5.addRadioButton("radio",100,240);
  r.setSpacingRow(20);
  r.setNoneSelectedAllowed(false);
  r.setSize(20, 20);
  r.addItem("1 karta", 0);
  r.addItem("3 karte", 1);
  r.activate(0);
  r.hideLabels();
  
  //postavljanje radio buttona na početni ekran (za biranje crvene ili plave ili zelene karte )
  controlP5 = new ControlP5(this);
  karta = controlP5.addRadioButton("radio",100,440);
  karta.setSpacingRow(20);
  karta.setNoneSelectedAllowed(false);
  karta.setSize(20, 20);
  karta.addItem("plava karta", 0);
  karta.addItem("crvena karta", 1);
  karta.addItem("zelena karta",2);
  karta.activate(0);
  karta.hideLabels();
  
  path_backg = sketchPath(audioName);
  file = new SoundFile(this, path_backg);
  file.loop(1.1, 0.35);
}

void draw()
{
  if(startMenuEnabled == true){ //prikazuje se početni ekran
    
    if(startAgain == true){
      startBoard();
      startAgain = false;
    }
    
    background(#44B92C);
    fill(0,0,0);
    textSize(60);
    fill(#020878);
    text("Solitaire",300,100);
    textSize(25);
    text("Koliko karata želite da vam se otvara iz špila?", 100, 220);
    text("1 karta", 140,260);
    text("3 karte", 140,300);
    
    text("Koju boju pozadine želite za svoje karte", 100, 420);
    text("plavu boju", 140,460);
    text("crvenu boju", 140,500);
    text("zelenu boju", 140, 540);

    if(mouseX>=590 && mouseX<=590+170 && mouseY>=570 & mouseY<=570+40)
    {
      fill(#6DDE55);
    }
    else
    {
      noFill();
    }
    rect(590,570,170,40);
    fill(#020878);
    text("Pokreni igru",600,600);
    if(mousePressed && mouseX>=590 && mouseX<=590+170 && mouseY>=570 & mouseY<=570+40){ //klik na gumb Pokreni igru
      Sekunde = second();
      Minute = -1;
      startMenuEnabled = false;
      if(r.getValue() == 0)
      {
        drawEvery = 1;
      }
      else if(r.getValue() == 1)
      {
        drawEvery = 3;
        lastFromDeck = 2;
      }
      if(karta.getValue() == 1) back = back_red;
      else if(karta.getValue() == 2)back = back_green;
      else if(karta.getValue() == 0) back = back_blue;
      r.removeItem("1 karta");
      r.removeItem("3 karte");
      karta.removeItem("plava karta");
      karta.removeItem("crvena karta");
      karta.removeItem("zelena karta");
    }
    
    hearts_A.drawCard(80, 40);
    spades_10.drawCard(620, 40);
    diamonds_Q.drawCard(180, 550);
    clubs_5.drawCard(320, 250);
    hearts_K.drawCard(680, 400);
    
  }
  else //prikazuje se ekran s igrom
  {
    if(restartGame == true){
      Bodovi = 0;
      Potezi = 0;
      Minute = 0;
      Sekunde = second();
      startBoard();
      restartGame = false;
    }
   
    if(beginning == 1) //prilikom prvog otvaranja postavljamo početnu ploču i špil iz kojeg kasnije izvlačimo karte
    {
       for(int i = 0; i < WIDTH_NUMBER; ++i)
       {
          for(int j = i; j < WIDTH_NUMBER; ++j)
          {
              Card card = cardList.get(0);
              board[i][j] = card;
              open[i][j] = 0;
              cardList.remove(0);
              cardListRem.add(card);
              if(i == j)
              {
                open[i][j] = 1;
              }
          }
       }
       drawBoard();
       beginning = 0;
       
       //punjenje spila
       int t = 0;
       while(cardList.size() >0){
         Card card = cardList.get(0);
         drawDeck[t] = card;
         cardList.remove(0);
         cardListRem.add(card);
         lengthDeck++;
         openDeck[t] = 0;
         t++;
       }
    }
    else //ako nije početak igre
    {
      int flag = 0;
      for(int i = 0; i < WIDTH_NUMBER; ++i)
      {
        int last = findLastCard(i);
        int firstOpen = findFirstOpen(i);
        
        if(last != -1 && firstOpen != -1)
        {
          if(mousePressed && dragging==false && mouseX>getXcoordinate(i) && mouseX<getXcoordinate(i) + CARD_WIDTH &&
           mouseY>getYcoordinate(last) && mouseY<getYcoordinate(last) + CARD_HEIGHT) //pritisnuto je na zadnju kartu u i-tom stupcu (povlači se jedna karta)
            {
             path_cards = sketchPath(cardSoundName);
             card_sound = new SoundFile(this, path_cards);
             card_sound.play(1.25);
             
             draggedCard = board[last][i];
             board[last][i] = null;
             open[last][i] = 0;
             draggedX = mouseX-CARD_WIDTH/2;
             draggedY = mouseY-CARD_HEIGHT/2;
             beginningX = getXcoordinate(i);
             beginningY = mouseY;
             dragging = true;
             flag = 2;
             break;
            }
          else if (mousePressed && dragging==false && mouseX>getXcoordinate(i) && mouseX<getXcoordinate(i) + CARD_WIDTH &&  mouseY>= XMARGIN + CARD_HEIGHT) //pritisnuto je na neku drugu kartu u i-tom stupcu(povlači se više karata)
          {
            path_cards = sketchPath(cardSoundName);
            card_sound = new SoundFile(this, path_cards);
            card_sound.play(1.25);
          
            int t = firstOpen;
            
            while(t<last){
              //trazimo od koje se karte povlači
              if(mouseY>getYcoordinate(t) && mouseY<getYcoordinate(t) + 30)
              {
                //karte koje se povlače stavljaju se u draggedCards, a njihove koordinate u draggedXs i draggedYs
                int j = t;
                nmbDraggedCards = last - j + 1;
                draggedCard = board[j][i];
                while(j <= last)
                {
                  draggedCards[j-t] = board[j][i];
                  draggedXs[j-t] = mouseX-CARD_WIDTH/2;;
                  draggedYs[j-t] = mouseY + (j-t)*30 -CARD_HEIGHT/2;
                  board[j][i] = null;
                  open[j][i] = 0;
                  ++j;
                }
                //pamitmo koordinate za kartu s najmanjim indeksom (draggedCard)
                 draggedX = mouseX-CARD_WIDTH/2;
                 draggedY = mouseY-CARD_HEIGHT/2;
                 beginningX = getXcoordinate(i);
                 beginningY = mouseY;
                 dragging = true;
                 flag = 1;
                 
                 break;
              }
              
              ++t;
            }
            if(flag == 1)
              break;
           }
           else if(mousePressed && dragging==false && i>=3 && mouseX>getXcoordinate(i) && mouseX<getXcoordinate(i) + CARD_WIDTH &&  mouseY< XMARGIN + CARD_HEIGHT && mouseY >= XMARGIN) //pritisnuto je na neki od špilova (povlačimo kartu natrag na ploču)
           {
             path_cards = sketchPath(cardSoundName);
             card_sound = new SoundFile(this, path_cards);
             card_sound.play(1.25);
             
             int lastIndex = findLastInDeck(i-3);
             if(lastIndex != -1)
             {
               draggedCard = decks[lastIndex][i-3];
               decks[lastIndex][i-3] = null;
               draggedX = mouseX-CARD_WIDTH/2;
               draggedY = mouseY-CARD_HEIGHT/2;
               beginningX = getXcoordinate(i);
               beginningY = mouseY;
               dragging = true;
               flag = 2;
               break;
             }
             
           }
        
          }
        }
      
      if (flag == 0 && lengthDeck > 0 && mousePressed && entered==false && mouseX>getXcoordinate(0) &&
      mouseX<getXcoordinate(0) + CARD_WIDTH && mouseY>XMARGIN && mouseY<XMARGIN + CARD_HEIGHT) //pritisnuto je na pozadinu karte za preostali špil karata u lijevom kutu (otvaramo novu 1 ili 3 karte)
      {
         Potezi++;
        path_cards = sketchPath(cardSoundName);
        card_sound = new SoundFile(this, path_cards);
        card_sound.play(1.1);
        entered = true;
        endField = false;
        isDeckOpened = true;
        
        if(endDeck == true) //ako smo došli do kraja špila
        {
          //oznaka da se otvorene karte moraju pobrisati
          endField = true;
          endDeck = false;
          isDeckOpened = false;
          
          //za svaki slučaj zatvaramo sve staro otvorene
          for(int i = 0; i < lengthDeck; ++i)
            openDeck[i] = 0;
            
          if(drawEvery == 1)  
            lastFromDeck = 0;
          if(drawEvery == 3)
            lastFromDeck = 2;
        }
        else{ //ako nismo došli do kraja špila
         if(lastFromDeck >= drawEvery)
         {
           //zatvori prethodno otvorene karte
           for(int j = 0; j < lengthDeck; ++j)
           {
             openDeck[j] = 0;
           }
         }
         if(lastFromDeck >= lengthDeck-1)
         {
           //ako smo na kraju špila otvori zadnjih drawEvery ili koliko ih ima
           int howMuch = drawEvery;
           if(lengthDeck < howMuch)
             howMuch = lengthDeck;
           
           for(int j = 0; j < howMuch; ++j)
           {
             openDeck[lengthDeck -1 - j] = 1;
           }
           
           previousFromDeck = lengthDeck-1;
           endDeck = true;
         }
         else
         {
           //inače otvori sljedeće
           int koliko = drawEvery;
           if(lengthDeck < koliko)
             koliko = lengthDeck;
           for(int j = 0; j < koliko; ++j)
           {
             openDeck[lastFromDeck - j] = 1;
           }
           //ovo će biti prethodno otvorena karta
           previousFromDeck = lastFromDeck;
           //sljedeće otvaramo za drawEvery kartu
           lastFromDeck += drawEvery;
         }
        }
      }
          
      if (flag == 0 && isDeckOpened == true && lengthDeck > 0 && mousePressed && entered2==false &&
      mouseY>XMARGIN && mouseY<XMARGIN + CARD_HEIGHT) //pritisnuto je na kartu iz preostali špila karata u lijevom kutu (povlačimo kartu iz špila na ploču)
      {
        path_cards = sketchPath(cardSoundName);
        card_sound = new SoundFile(this, path_cards);
        card_sound.play(1.25);
             
        int flagE = 0;
        if(mouseX>getXcoordinate(1) && mouseX<getXcoordinate(1) + CARD_WIDTH + 40)
        {
         if(drawEvery == 3 && previousFromDeck == 1 && mouseX>getXcoordinate(1)+20 && mouseX<getXcoordinate(1) + CARD_WIDTH + 20) //ako je izabrano otvaranje 3 karte, ali su zadnje 2 u špilu
         {
           beginningX = getXcoordinate(1) + 20;
           flagE = 1;
         }
         else if(drawEvery == 3 && previousFromDeck >= 2 && mouseX>getXcoordinate(1)+40 && mouseX<getXcoordinate(1) + CARD_WIDTH + 40) //ako je izabrano otvaranje 3 karte, ali je zadnja u špilu
         {
           beginningX = getXcoordinate(1) + 40;
           flagE = 1;
         }
         else if(((drawEvery == 3 && previousFromDeck == 0) || drawEvery==1) && mouseX>getXcoordinate(1) && mouseX<getXcoordinate(1) + CARD_WIDTH) //inače (otvorene sve 3 ili izabrano otvaranje 1 karte)
         {
           beginningX = getXcoordinate(1);
           if(drawEvery == 1)
           {
             if(previousFromDeck != 0)
               openDeck[previousFromDeck-1] = 1;
           }
           flagE = 1;
         }
         
         if(flagE == 1) //ako vrijedi nešto od prošlog
         {
           nmbDraggedCards = 0;
           draggedCard = drawDeck[previousFromDeck];
           openDeck[previousFromDeck] = 0;
           draggedX = mouseX-CARD_WIDTH/2;
           draggedY = mouseY-CARD_HEIGHT/2;
           beginningY = mouseY;
         
           entered2 = true;
         }
        }
      }
      drawBoard();
    }
  }
}

// funkcija koja dohvaća x koordinatu x-tog stupca
int getXcoordinate(int x)
{
  return XMARGIN+x*(CARD_WIDTH+SPACESIZE);
}

// funkcija koja dohvaća y koordinatu y-tog stupca
int getYcoordinate(int y)
{
  return XMARGIN + CARD_HEIGHT + SPACESIZE + y*30;
}

// funkcija koja postavlja varijable na početno stanje (za ponovno pokretanje igre)
void startBoard()
{
  //ponovna inicijalizacija igre
  for(int i = 0; i < HEIGHT_NUMBER; ++i)
    {
       for(int j = 0; j < WIDTH_NUMBER; ++j)
       {
          board[i][j] = null;
          open[i][j] = 0;
       }
    }
    
    for(int i = 0; i < 4; ++i)
      for(int j = 0; j < 13; ++j)
      {
        decks[j][i] = null;
      }
    
    for(int i = 0; i < 13; ++i)
    {
      draggedCards[i] = null;
      draggedXs[i] = 0;
      draggedYs[i] = 0;
    }
    
    draggedCard = null;
    dragging = false;
    
    while(cardListRem.size()>0){
      Card card = cardListRem.get(0);
      cardListRem.remove(0);
      cardList.add(card);
    }
    
    Collections.shuffle(cardList);
    
    beginning = 1;
    
    if(restartGame == false)
      startMenuEnabled = true;
    else
      startMenuEnabled = false;
    startAgain = false;
    lengthDeck = 0;
    lastFromDeck = 0;
    nmbDraggedCards = 0;
    previousFromDeck = 0;
    if(drawEvery == 1)
      lastFromDeck = 0;
    else 
      lastFromDeck = 2;
    endDeck = false;
    endField = false;
    entered = false;
    entered2 = false;
    endGame = false;
    isDeckOpened = false;
    restartGame = false;
    fastEnd = true;
    endChecked = false;
}

// funkcija koja crta stanje na ploči u nekom trenutku u igri
void drawBoard()
{
  if(startMenuEnabled == true){
    return;
  }
  
  background(#44B92C);
  int x, y;
  for(int i = 0; i < HEIGHT_NUMBER; ++i) // iscrtavanje ploče sa 7 stupaca
  {
    y = getYcoordinate(i);
    for(int j = 0; j < WIDTH_NUMBER; ++j)
    { 
      x = getXcoordinate(j);
      
      if(i == 0)
      {
        stroke(0);
        noFill();
        rect(x, y, CARD_WIDTH, CARD_HEIGHT);
      }
      
      Card card = board[i][j];
      if(card != null && open[i][j] == 1)
        card.drawCard(x, y);
      else if(card != null)
      {
         back.drawCard(x, y);
      }
      
    }
  }
    
  for(int i = 3; i < WIDTH_NUMBER; ++i) //iscrtavanje 4 špila
  {
    x = getXcoordinate(i);
    y = XMARGIN;
    
    stroke(0);
    noFill();
    rect(x, y, CARD_WIDTH, CARD_HEIGHT, 5);
    
    int j = 0;
    while(j<13 && decks[j][i-3]!=null)
    {
      decks[j][i-3].drawCard(x, y);
      j++;
    }
    
  }
  
  // iscrtavanje špila u ljievom gornjem kutu
  x = getXcoordinate(0);
  y = XMARGIN;
  
  stroke(0);
  noFill();
  rect(x, y, CARD_WIDTH, CARD_HEIGHT);
  
  if(endDeck == false){
    back.drawCard(x,y);

  }
  
  // iscrtavanje otvorenih karata iz tog špila
  if(endField == false)
  {

    x = getXcoordinate(1);
    y = XMARGIN;
  
    if(drawEvery == 1){
      for(int i = 0; i<lengthDeck;++i){
        if(openDeck[i] == 1){
          
          stroke(0);
          noFill();
          rect(x, y, CARD_WIDTH, CARD_HEIGHT, 5);
          drawDeck[i].drawCard(x, y);
        }
      }
    }else{
      for(int i = 0; i<lengthDeck;++i){
        if(openDeck[i] == 1){
          
          stroke(0);
          noFill();
          rect(x, y, CARD_WIDTH, CARD_HEIGHT, 5);
          drawDeck[i].drawCard(x, y);
          
          if(i+1 < lengthDeck && openDeck[i+1] == 1){
            stroke(0);
            noFill();
            rect(x+20, y, CARD_WIDTH, CARD_HEIGHT, 5);
            drawDeck[i+1].drawCard(x + 20, y);
          }
          
          if(i+2 < lengthDeck && openDeck[i+2] == 1){
            stroke(0);
            noFill();
            rect(x+40, y, CARD_WIDTH, CARD_HEIGHT, 5);
            drawDeck[i+2].drawCard(x + 40, y);
          }
                      
          break;
        }
      }
    }
  }
  
  //gumb za povratak na izbornik  
  if(mouseX>=10 && mouseX<=10+170 && mouseY>=660 & mouseY<=660+35)
  {
    fill(#6DDE55);
  }
  else
  {
    noFill();
  }
  rect(10,660,170,35);
  fill(#020878);
  textSize(15);
  text("Povratak na izbornik",20,680);
    
  if(mousePressed && mouseX>=10 && mouseX<=10+170 && mouseY>=660 & mouseY<=660+35){
    startMenuEnabled = true;
    startAgain = true;
    r.addItem("1 karta", 0);
    r.addItem("3 karte", 1);
    r.activate(0);
    r.hideLabels();
    karta.addItem("plava karta", 0);
    karta.addItem("crvena karta", 1);
    karta.addItem("zelena karta",21);
    karta.activate(0);
    karta.hideLabels();
    return;
  }
  
  //gumb za novu igru
  if(mouseX>=190 && mouseX<=190+90 && mouseY>=660 & mouseY<=660+35)
  {
    fill(#6DDE55);
  }
  else
  {
    noFill();
  }
  rect(190,660,90,35);
  fill(#020878);
  textSize(15);
  text("Nova igra",200,680);
  if(!endGame) {
    Razlika_sekundi = second() - Sekunde;
  }
  if (Razlika_sekundi < 0) Razlika_sekundi += 60;
  if (Razlika_sekundi % 10 == 0 && ulovi) {
    Bodovi -=2;
    ulovi = false;
  }
  if((Razlika_sekundi == 0 || Razlika_sekundi == 60) && minuta_ulovi) {
    Minute ++;
    minuta_ulovi = false;
  }
  if(Razlika_sekundi == 1) minuta_ulovi = true;
  if (Razlika_sekundi % 10 == 1) ulovi = true;
  if (Bodovi < 0) Bodovi = 0;
  String natpis_bodovi = "Bodovi: " + Bodovi;
  text(natpis_bodovi, 300, 680);
  String proteklo_vrijeme;
  if (Minute < 10) proteklo_vrijeme = "Vrijeme: 0" + Minute;
  else proteklo_vrijeme = "Vrijeme: " + Minute;
  if (Razlika_sekundi < 10) proteklo_vrijeme += ":0" + Razlika_sekundi;
  else proteklo_vrijeme += ":" + Razlika_sekundi;
  text(proteklo_vrijeme, 400, 680);
  String broj_poteza = "Potezi: " + Potezi;
  text(broj_poteza, 500, 680);
    
  if(mousePressed && mouseX>=190 && mouseX<=190+90 && mouseY>=660 & mouseY<=660+35){
    restartGame = true;
    //startAgain = true;
    return;
  }
  
  // iscrtavanje karata koje se povlače
  if(draggedCard != null && nmbDraggedCards == 0)
    draggedCard.drawCard(draggedX, draggedY);
    
  for(int i = 0; i < 13; ++ i)
  {
    if(draggedCards[i] != null)
    {
      draggedCards[i].drawCard(draggedXs[i], draggedYs[i]);
    }
  }
  
  if(endGame == true){ // iscrtavanje poruke za kraj igre
    textSize(60);
    fill(#020878);
    text("Čestitamo!", 250, 350);
    text("Uspješno ste završili igru!", 20, 450);
  }
  
  if(endChecked == true && fastEnd == true) //automatsko završavanje igre
  {
    fill(255);
    rect(250,330,300,90);
    
    fill(#020878);
    text("Želite li da se igra automatski završi?", 250, 350);
    if(mouseX>=375 && mouseX<=375+30 && mouseY>=355 & mouseY<=355+30)
    {
      fill(#6DDE55);
    }
    else
    {
      noFill();
    }
    rect(375,355,30,30);
    fill(#020878);
    textSize(15);
    text("DA", 350, 370);
      
    if(mousePressed && mouseX>=375 && mouseX<=375+30 && mouseY>=355 & mouseY<=355+30){
   
      while(!isGameOver()){
        for(int i = 0; i < WIDTH_NUMBER; ++i)
        {
          int last = findLastCard(i);
          if(last != -1)
          {
            for(int k = 0; k < 4; ++k)
            {
              if(follows_onDecks(board[last][i], k))
              {
                Bodovi+=15;
                Potezi++;
                System.out.println("petlja?");
                decks[findLastInDeck(k)+1][k] = board[last][i];
                board[last][i]= null;
                open[last][i] = 0;
                //ukoliko je tu break bude besk petalja, sa return se nakon nekoliko pritisaka da završi
                //break;               
                return;
              }
            }  
          
          }
        }
      }
      endGame = true;
      endChecked = false;
      return;
    }
    if(mouseX>=435 && mouseX<=435+30 && mouseY>=355 & mouseY<=355+30)
    {
      fill(#6DDE55);
    }
    else
    {
      noFill();
    }
    rect(435,355,30,30);
    fill(#020878);
    textSize(15);
    text("NE", 410, 370);
      
    if(mousePressed && mouseX>=435 && mouseX<=435+30 && mouseY>=355 & mouseY<=355+30){
      endChecked = false;
      fastEnd = false;
      return;
    }
  }
  
}

// funkcija koja pronalazi redak u kojem se nalazi zadnja karta u stupcu column
int findLastCard(int column)
{
  for(int j = 0; j < HEIGHT_NUMBER; ++j)
  {
    if(j!=HEIGHT_NUMBER-1 && board[j][column] != null && board[j+1][column] == null)
      return j;
    if(j==HEIGHT_NUMBER-1 && board[j][column] != null)
      return j;
  }
  return -1;
}

// funkcija koja pronalazi indeks zadnje karte u nekom od 4 špila
int findLastInDeck(int column)
{
    int lastIndex = -1;
    for(int i = 0; i < 13; ++i)
      {
        if(decks[i][column] == null){
          lastIndex = i - 1;
          break;
        }
      }
    return lastIndex;
}

// funkcija koja pronalazi prvu otvorenu kartu u određenom stupcu
int findFirstOpen(int column)
{
  for(int j = 0; j < HEIGHT_NUMBER; ++j)
  {
    if(open[j][column] == 1)
      return j;
  }
  return -1;
}

// funkcija koja provjerava može li karta card doći na kraj stupca column na ploči
boolean follows_onBoard(Card card, int column)
{
  int row = findLastCard(column);
  if(row == -1 && card.number == 13)
    return true;
  else if(row == -1)
    return false;
  else
  {
    Card last = board[row][column];
    if(card.number == last.number - 1 && !(card.colour.equals(last.colour)))
      return true;
    else return false;
  }
}

// funkcija koja provjerava može li karta card doći na kraj špila s indeksom column
boolean follows_onDecks(Card card, int column)
{
  int lastIndex = -2;
  for(int i = 0; i < 13; ++i)
  {
    if(decks[i][column] == null){
      lastIndex = i - 1;
      break;
    }
  }
  
  if(lastIndex == -1 && card.number == 1)
    return true;
  else if(lastIndex == -1 && card.number != 1)
    return false;
  else if(lastIndex == -2)
    return false;
  else
  {
    System.out.println(decks[lastIndex][column].number + 1);
    Card last = decks[lastIndex][column];
    if(card.number == last.number + 1 && card.suit.equals(last.suit))
      return true;
    else return false;
  }
}


// funkcija koja provjerava može li se igra automatski završiti
boolean checkEnd()
{
  for(int i = 0; i < WIDTH_NUMBER; ++i)
  {
    if(board[0][i] != null && open[0][i] == 0)
      return false;
  }
  if(lengthDeck != 0)
    return false;
  
  return true;
  
}

// funkcija koja provjerava je li igra gotova
boolean isGameOver()
{
    int flagT = 0;
    for(int i = 0; i < 4; ++i){
      if(decks[12][i] == clubs_K || decks[12][i] == diamonds_K || decks[12][i] == spades_K || decks[12][i] == hearts_K)
      flagT += 1;
    }
    if(flagT == 4)
      return true;
      
   return false;
}

void mouseClicked(MouseEvent e){
  if(e.getCount() == 2 && startMenuEnabled == false)
  {
    int x = -1, last = -1, pom1 = -1, pom2 = -1, row = -1, y;
    Card clickedCard = null;
     for(int i = 0; i < WIDTH_NUMBER; ++i)
      {
        x = getXcoordinate(i);
        y = getYcoordinate(findLastCard(i));
        last = findLastCard(i);
        
        if(i == 1 && (drawEvery == 1 ||(drawEvery == 3 && previousFromDeck == 0) )&& mouseX >= x && mouseX <= x + CARD_WIDTH &&
        mouseY >= XMARGIN && mouseY <= XMARGIN + CARD_HEIGHT){
          pom2 = 1; //ako izaberemo iz špila kartu
                      
        }
        else if(i == 1 && drawEvery == 3 && previousFromDeck == 1 && mouseX >= x+20 && mouseX <= x + CARD_WIDTH+20 &&  mouseY >= XMARGIN && mouseY <= XMARGIN + CARD_HEIGHT)
        {
          pom2 = 1;
                      
        }
        else if(i ==1 && drawEvery == 3 && previousFromDeck >= 2 && mouseX >= x+40 && mouseX <= x + CARD_WIDTH+40 &&  mouseY >= XMARGIN && mouseY <= XMARGIN + CARD_HEIGHT)
        {
          pom2 = 1;
                      
        }
        else if(mouseX >= x && mouseX <= x + CARD_WIDTH && mouseY >= y && mouseY <= y + CARD_HEIGHT)
        {
          pom1 = i; //stupac iz kojeg smo počeli povlačiti kartu
                      
    
        }
      }
      
      if(pom2 != -1)
      {
        clickedCard = drawDeck[previousFromDeck];
      }
      if(pom1 != -1)
      {
        
        row = findLastCard(pom1);
        clickedCard = board[row][pom1];
      }
      
      if(clickedCard == null)
        return;
      
     for(int i = 0; i < 4; ++i)
     {
       if(follows_onDecks(clickedCard, i))
       {
          Bodovi += 10;
          Potezi++;
          int lastIndex = findLastInDeck(i);
          decks[lastIndex + 1][i] = clickedCard;
          if(pom1 != -1)
          {
            board[row][pom1] = null;
            open[row][pom1] = 0;
            if(row>0){
              open[row-1][pom1] = 1;
            }
          }
          if(pom2 != -1)
          {
            for(int j=previousFromDeck;j<lengthDeck;++j)
            {
              if(j!=lengthDeck-1)
                drawDeck[j] = drawDeck[j+1];
            }
            
            if(drawEvery == 1){
              //update koja je sada zadnja otvorena u špilu
              for(int k = 0; k < lengthDeck -1; ++k)
              {
                openDeck[k] = 0;
              }
              if(previousFromDeck !=0)
              {
                previousFromDeck -= 1;
                openDeck[previousFromDeck] = 1;
              }
              lastFromDeck -=1;
            }
            if(drawEvery == 3)
            {
              if(previousFromDeck>=drawEvery)
                openDeck[previousFromDeck-drawEvery] = 1;
                
              if(previousFromDeck == 2)
                for(int t = 2; t < lengthDeck -1; ++t)
                {
                  openDeck[t] = 0;
                }
              if(previousFromDeck !=0)
                previousFromDeck -= 1;
                lastFromDeck -=1;
            }
            lengthDeck--;

          }

          if(isGameOver()){
            endGame = true;
          }
          return;
       }
     }
     
      
  }
  else
    dragging = true;
}

void mouseDragged(){
  dragging = true;
  entered = true;
  entered2 = true;
  draggedX = mouseX - CARD_WIDTH/2;
  draggedY = mouseY - CARD_HEIGHT/2;
  for(int i = 0; i < nmbDraggedCards; ++i)
  {
    draggedXs[i] = mouseX - CARD_WIDTH/2;
    draggedYs[i] = mouseY + i*30 - CARD_WIDTH/2;
  }
}

void mouseReleased(){
  dragging = false;
  entered = false;
  entered2 = false;
  int flag = 0;
  int cnt = 0;
  if(draggedCard == null)
  {
    for(int i = 1; i < 13; ++i){
      if(draggedCards[i] != null){
        flag = 1;
        cnt++;
      }
    }
    if(flag == 0)
      return;
  }
  int x = -1, row, pom1 = -1, pom2 = -1, pom3 = -1, last;
  int pom4 = -1, pom5 = -1, pom6 = -1;
  
  for(int i = 0; i < WIDTH_NUMBER; ++i)
  {
    x = getXcoordinate(i);
    last = findLastCard(i);
    
    if(drawEvery == 1 && i < 3 && beginningX >= x && beginningX <= x + CARD_WIDTH &&  beginningY >= XMARGIN && beginningY <= XMARGIN + CARD_HEIGHT){
      pom4 = 1; //ako izaberemo iz špila kartu
    }
    else if(drawEvery == 3 && i < 3 && beginningX >= x && beginningX <= x + CARD_WIDTH &&  beginningY >= XMARGIN && beginningY <= XMARGIN + CARD_HEIGHT){
      pom4 = 1; //ako izaberemo iz špila kartu
    }
    else if(i >= 3 && beginningX >= x && beginningX <= x + CARD_WIDTH &&  beginningY >= XMARGIN && beginningY <= XMARGIN + CARD_HEIGHT){
      pom6 = i; //ako izaberemo iz decks
    }
    else if(beginningX >= x && beginningX <= x + CARD_WIDTH)
    {
      pom1 = i; //stupac iz kojeg smo počeli povlačiti kartu

    }
    if(mouseX >= x && mouseX <= x + CARD_WIDTH)
    {
      if(mouseY >= getYcoordinate(last))
        pom2 = i; //stupac do kojeg smo povukli kartu ako smo ju povukli na neko mjesto u boardu
      else if(i>=3 && mouseY >= XMARGIN && mouseY <= XMARGIN + CARD_HEIGHT && nmbDraggedCards==0)
        pom3 = i; //stupac do kojeg smo povukli kartu ako smo ju povukli na neko mjesto u decks
      else if(i==1 && mouseY >= XMARGIN && mouseY <= XMARGIN + CARD_HEIGHT)
        pom5 = 1; //ako smo stavili kartu na otvorene karte iz špila
    }
  }
  
  if(pom1!= -1 && pom1 == pom2)
  {
    row = findLastCard(pom1);
    board[row+1][pom1] = draggedCard;
    open[row+1][pom1] = 1;
    
    draggedCards[0] = null;
    for(int i=1; i < nmbDraggedCards;++i)
    {
        board[row+1+i][pom1] = draggedCards[i];
        open[row+1+i][pom1] = 1;
        draggedCards[i] = null;
        draggedXs[i] = 0;
        draggedYs[i] = 0;
    }
    nmbDraggedCards = 0;
    
  }
  else if(pom1!=-1 && pom2 != -1 && follows_onBoard(draggedCard, pom2) && findLastCard(pom2)+1 <13 && findLastCard(pom2)+nmbDraggedCards <13)
  {
    Bodovi += 5;
    Potezi++;
    row = findLastCard(pom2);
    board[row+1][pom2] = draggedCard;
    open[row+1][pom2] = 1;
    
    draggedCards[0] = null;
    for(int i=1; i < nmbDraggedCards;++i)
    {
        board[row+1+i][pom2] = draggedCards[i];
        open[row+1+i][pom2] = 1;
        draggedCards[i] = null;
        draggedXs[i] = 0;
        draggedYs[i] = 0;
    }
    nmbDraggedCards = 0;
    
    row = findLastCard(pom1);
    if(row != -1)
      open[row][pom1] = 1;
  }
  else if(pom1!=-1 && pom3 != -1 && follows_onDecks(draggedCard, pom3 - 3))
  {
    Bodovi += 10;
    Potezi++;
    int lastIndex = findLastInDeck(pom3-3);
    decks[lastIndex + 1][pom3 - 3] = draggedCard;

    draggedCards[0] = null;
    for(int i = 1; i < nmbDraggedCards;++i)
    {
        draggedCards[i] = null;
        draggedXs[i] = 0;
        draggedYs[i] = 0;
    }
    nmbDraggedCards = 0;
    
    row = findLastCard(pom1);
    if(row != -1)
      open[row][pom1] = 1;
      
    if(isGameOver()){
       endGame = true;
    }
  }
  else if(pom4 != -1 && pom4 == pom5)
  {
            
    if(drawEvery == 1){
      if(previousFromDeck !=0)
      {
        openDeck[previousFromDeck] = 1;
        openDeck[previousFromDeck-1] = 0;
      }
      else
      {
        openDeck[0] = 1;
      }
    }
    if(drawEvery == 3){
      openDeck[previousFromDeck] = 1;
    }
  }
  else if(pom4!= -1 && pom2 != -1 && follows_onBoard(draggedCard, pom2) && findLastCard(pom2)+1 <13)
  {
    Bodovi += 5;
    Potezi++;
    row = findLastCard(pom2);
    board[row+1][pom2] = draggedCard;
    open[row+1][pom2] = 1;
    if(previousFromDeck == 0)
      isDeckOpened = false;
    //brišemo kartu iz špila
    for(int i=previousFromDeck;i<lengthDeck;++i)
    {
      if(i!=lengthDeck-1)
        drawDeck[i] = drawDeck[i+1];
    }
    
    if(drawEvery ==1){
      //update koja je sada zadnja otvorena u špilu
      if(previousFromDeck !=0)
        previousFromDeck -= 1;
        lastFromDeck -=1;

    }
    if(drawEvery == 3)
    {
      if(previousFromDeck>=drawEvery)
        openDeck[previousFromDeck-drawEvery] = 1;
        
      if(previousFromDeck !=0)
        previousFromDeck -= 1;
        lastFromDeck -=1;
    }
    lengthDeck--;
  }
  else if(pom4 != -1 && pom3!= -1 && follows_onDecks(draggedCard, pom3 - 3))
  {
    int lastIndex = findLastInDeck(pom3-3);
    decks[lastIndex + 1][pom3 - 3] = draggedCard;
    
    Bodovi += 10;
    Potezi++;
    
    if(previousFromDeck == 0)
      isDeckOpened = false;
    //brisemo kartu iz špila
    for(int i=previousFromDeck;i<lengthDeck;++i)
    {
      if(i!=lengthDeck-1)
        drawDeck[i] = drawDeck[i+1];
    }
    
    if(drawEvery ==1){
      //update koja je sada zadnja otvorena u špilu
      if(previousFromDeck !=0)
        previousFromDeck -= 1;
        lastFromDeck -=1;

    }
    if(drawEvery == 3)
    {
      if(previousFromDeck>=drawEvery)
        openDeck[previousFromDeck-drawEvery] = 1;
        
      if(previousFromDeck !=0)
        previousFromDeck -= 1;
        lastFromDeck -=1;
    }
    lengthDeck--;
    
    if(isGameOver()){
            endGame = true;
          }

  }
  else if(pom4!= -1)
  {

    if(drawEvery == 1){
      if(previousFromDeck !=0)
      {
        openDeck[previousFromDeck] = 1;
        openDeck[previousFromDeck-1] = 0;
      }
      else
      {
        openDeck[0] = 1;
      }
    }
    if(drawEvery == 3){
      openDeck[previousFromDeck] = 1;
    }
  }
  else if(pom6!= -1 && pom3!=-1 && pom6 != pom3 && findLastInDeck(pom6-3) == -1 && findLastInDeck(pom3-3) == -1)
  {
    decks[0][pom3-3] = draggedCard;
    
  }
  else if(pom6!= -1 && pom2 != -1 && follows_onBoard(draggedCard, pom2) && findLastCard(pom2)+1 <13)
  {
                 Potezi++;
    row = findLastCard(pom2);
    board[row+1][pom2] = draggedCard;
    open[row+1][pom2] = 1;
    
    
  }
  else if(pom6!=-1)
  {            
    int lastIndex = findLastInDeck(pom6-3);
    decks[lastIndex+1][pom6-3] = draggedCard;
    
  }
  else
  {

    row = findLastCard(pom1);
    board[row+1][pom1] = draggedCard;
    open[row+1][pom1] = 1;
    
    draggedCards[0] = null;
    for(int i=1; i < nmbDraggedCards;++i)
    {
        board[row+1+i][pom1] = draggedCards[i];
        open[row+1+i][pom1] = 1;
        draggedCards[i] = null;
        draggedXs[i] = 0;
        draggedYs[i] = 0;
    }
    nmbDraggedCards = 0;
  }
  
  if(checkEnd() && endChecked == false)
  {
    endChecked = true;
  }
  draggedCard = null;
  nmbDraggedCards = 0;
}

class Card
{
  int number;
  String suit;
  String colour;
  PImage image;
  
  Card(String pictureName, int num, String su, String col)
  {
    number = num;
    suit = su;
    colour = col;
    image = loadImage(pictureName + ".png");
    image.resize(CARD_WIDTH, CARD_HEIGHT);
  }
  
  void drawCard(int x, int y)
  {
    image(image, x, y);
  }
  
  String toString()
  {
      return suit + "(" + colour + "): " + number;
  }
  
}
