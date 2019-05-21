import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import controlP5.*;

ControlP5 cp5;
DropdownList d1, d2;
ArrayList<City> cities = new ArrayList<City>();
Disease disease;
Cure cure;
int points;
int pointRate;
ArrayList<String> news;
PImage img;
String[] TMStrings;
JComboBox TMList;
JLabel TMText;
int totalDead;

void citySetup() {
  ArrayList<String> adjacent = new ArrayList<String>();
  adjacent.add("Opelucid City");
  City League = new City("Pokemon League", 1000000, adjacent, true, false, 730, 60);
  cities.add(League);

  ArrayList<String> adjacent1 = new ArrayList<String>();
  adjacent1.add("Pokemon League");
  adjacent1.add("Lacunesa Town");
  adjacent1.add("Icirrus City");
  City Opelucid = new City("Opelucid City", 1000000, adjacent1, true, false, 610, 175);
  cities.add(Opelucid);

  ArrayList<String> adjacent2 = new ArrayList<String>();
  adjacent2.add("Opelucid City");
  adjacent2.add("Undella Town");
  City Lacunesa = new City("Lacunesa Town", 1000000, adjacent2, true, false, 865, 175);
  cities.add(Lacunesa);

  ArrayList<String> adjacent3 = new ArrayList<String>();
  adjacent3.add("Opelucid City");
  adjacent3.add("Mistralton City");
  City Icirrus = new City("Icirrus City", 1000000, adjacent3, true, false, 365, 175);
  cities.add(Icirrus);

  ArrayList<String> adjacent4 = new ArrayList<String>();
  adjacent4.add("Lacunesa Town");
  adjacent4.add("Black City");
  City Undella = new City("Undella Town", 1000000, adjacent4, true, false, 1030, 300);
  cities.add(Undella);

  ArrayList<String> adjacent5 = new ArrayList<String>();
  adjacent5.add("Icirrus City");
  adjacent5.add("Driftveil City");
  City Mistralton = new City("Mistralton City", 1000000, adjacent5, true, false, 170, 300);
  cities.add(Mistralton);

  ArrayList<String> adjacent6 = new ArrayList<String>();
  adjacent6.add("Undella Town");
  adjacent6.add("Nimbasa City");
  City Black = new City("Black City", 1000000, adjacent6, true, true, 865, 425);
  cities.add(Black);

  ArrayList<String> adjacent7 = new ArrayList<String>();
  adjacent7.add("Nimbasa City");
  adjacent7.add("Mistralton City");
  City Driftveil = new City("Driftveil City", 1000000, adjacent7, true, true, 365, 425);
  cities.add(Driftveil);

  ArrayList<String> adjacent8 = new ArrayList<String>();
  adjacent8.add("Black City");
  adjacent8.add("Driftveil City");
  adjacent8.add("Castelia City");
  City Nimbasa = new City("Nimbasa City", 1000000, adjacent8, true, false, 610, 425);
  cities.add(Nimbasa);

  ArrayList<String> adjacent9 = new ArrayList<String>();
  adjacent9.add("Nimbasa City");
  adjacent9.add("Nacrene City");
  City Castelia = new City("Castelia City", 1000000, adjacent9, true, true, 610, 600);
  cities.add(Castelia);

  ArrayList<String> adjacent10 = new ArrayList<String>();
  adjacent10.add("Castelia City");
  adjacent10.add("Straiton City");
  City Nacrene = new City("Nacrene City", 1000000, adjacent10, false, true, 920, 500);
  cities.add(Nacrene);

  ArrayList<String> adjacent11 = new ArrayList<String>();
  adjacent11.add("Nacrene City");
  adjacent11.add("Accumula Town");
  City Straiton = new City("Straiton City", 1000000, adjacent11, false, false, 1040, 480);
  cities.add(Straiton);

  ArrayList<String> adjacent12 = new ArrayList<String>();
  adjacent12.add("Straiton City");
  adjacent12.add("Nuvema Town");
  City Accumula = new City("Accumula Town", 1000000, adjacent12, false, false, 1070, 570);
  cities.add(Accumula);

  ArrayList<String> adjacent13 = new ArrayList<String>();
  adjacent13.add("Accumula Town");
  City Nuvema = new City("Nuvema Town", 1000000, adjacent13, false, true, 1100, 660);
  cities.add(Nuvema);

  ArrayList<String> adjacent14 = new ArrayList<String>();
  City Unity = new City("Unity Tower", 1000000, adjacent14, true, true, 410, 700);
  cities.add(Unity);
}

void drawCities() {
  for (int i=0; i<cities.size(); i++) {
    ellipse(cities.get(i).x, cities.get(i).y, 65, 65);
  }  
}

void spreadDisease(City c) {
  double rate = (disease.infectivity) * ((c.population-c.diseased) / (c.population * 1.0)) * c.diseased;
  c.diseased += Math.ceil(rate);
}

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190)); 
  ddl.setItemHeight(20);
  ddl.setBarHeight(30);
  ddl.getCaptionLabel().set("<Transmission>");
  ddl.setColorBackground(color(60)); 
  ddl.setColorActive(color(255, 128));
}

void Confirm(){
  if (d1.getValue() != 0){
    disease.addTMutation(disease.accessibleTMutations.get((int) d1.getValue() - 1));
    d1.clear();
    d1.addItem("<Transmission>", 0);
    for (int i=1; i<=disease.accessibleTMutations.size(); i++) {
      d1.addItem(disease.accessibleTMutations.get(i-1).name, i);
    }
  }
}

void updateDiseaseLabels(){
  fill(205);
  rect(1220, 0, 200, 22);
  fill(0, 0, 0);
  text("Infectivity: " + (int) (disease.infectivity * 10000) + " / 100", 1220, 20);
  fill(205);
  rect(1220, 30, 200, 22);
  fill(0, 0, 0);
  text("Severity: " + (int) (disease.severity * 10000) + " / 100", 1220, 50);
  fill(205);
  rect(1220, 60, 200, 22);
  fill(0, 0, 0);
  text("Lethality: " + (int) (disease.lethality * 10000) + " / 100", 1220, 80);
  fill(205);
  rect(1220, 90, 100, 22);
  fill(0, 0, 0);
  text("Points: " + points, 1220, 110);
}

void setup() {
  size(1440, 785);
  img = loadImage("map.png");
  image(img, 0, 0);

  citySetup();
  drawCities();
  disease = new Disease();
  cure = new Cure();
  points = 0;
  pointRate = 1;
  news = new ArrayList(); //ADD FEATURE LATER WHERE PAST NEWS IS IN A DROPDOWN MENU

  textSize(16);
  fill(0, 0, 0);
  text("Infectivity: " + (int) (disease.infectivity * 10000) + " / 100", 1220, 20);
  text("Severity: " + (int) (disease.severity * 10000) + " / 100", 1220, 50);
  text("Lethality: " + (int) (disease.lethality * 10000) + " / 100", 1220, 80);
  text("Points: " + 0, 1220, 110);
  text("Cure: " + 0 + "%", 1220, 140);
  cp5 = new ControlP5(this);
  d1 = cp5.addDropdownList("<Transmission>").setPosition(1220, 150);
  d1.addItem("<Transmission>", 0);
  for (int i=1; i<=disease.accessibleTMutations.size(); i++) {
    d1.addItem(disease.accessibleTMutations.get(i-1).name, i);
  }
  customize(d1);
  cp5.addButton("Confirm").setValue(0).setPosition(1220, 500).setSize(100, 40);
  d1.clear();
  d1.addItem("<Transmission>", 0);
  for (int i=1; i<=disease.accessibleTMutations.size(); i++) {
    d1.addItem(disease.accessibleTMutations.get(i-1).name, i);
  }

  cities.get(0).diseased = 1;
}

void draw() {
  totalDead = 0;
  for (City c : cities) {
    spreadDisease(c);
    totalDead += c.dead;
    c.updateDiseasedCount();
    c.updateColor();
    updateDiseaseLabels();
    if (c.diseased > 1000000) {
      c.diseased = 1000000;
    }
    c.landTransmission();
  }
  //rudimentary cure rate, very subject to change
  if (totalDead >= 10000 ) {
    if (cure.developed() <= 100){
      cure.setDeveloped(pow(totalDead * 0.000001,2));
    }
    if (cure.developed() > 100){
      cure.setDeveloped(100);
    }
    fill(205);
    rect(1220,120,100,22);
    fill(0,0,0);
    text("Cure: " + (int)cure.developed() + "%", 1220, 140);
  }
  
  if (Math.random() < (1/180.0)){
    points += pointRate;
  }
}

void mousePressed() {
  for (City c : cities) {
    //pops bubble if bubble is above the city and adds 2 points
    //this if statement calculates if mouse coords is within the bubble's hitbox
    if ((Math.pow((mouseX - c.x), 2) + Math.pow((mouseY - c.y), 2) < 225) && c.hasBubble) {
      c.bubblePopped = true;
      fill(255, 255, 255);
      ellipse(c.x, c.y, 35, 35);
      //when bubblePopped, c.hasBubble is set to false b/c of updateColor method within City class
      points+= 2;
      //CAN PLAY AROUND WITH GAME DESIGN IF PLAYER CHOOSES TO IGNORE BUBBLE OR POPS IT MORE QUICKLY,
      //etc, don't have to be as rigid as following actual game 100%
    }
  }
  //processing background color
}
