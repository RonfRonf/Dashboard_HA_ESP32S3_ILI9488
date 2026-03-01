// ============================================================
//  Dashboard Enclosure — ILI9488 3.5" + ESP32-S3
//  OpenSCAD parametric design — print in 2 parts
//
//  PARTI:
//    1. Front Bezel  → esportare come front_bezel.stl
//    2. Back Shell   → esportare come back_shell.stl
//
//  Impostazioni stampa consigliate:
//    - Layer height : 0.2 mm
//    - Infill       : 20–30 %
//    - Supporti     : NON necessari
//    - Materiale    : PLA / PETG
//    - Perimetri    : 3+
//    - Orientamento : faccia piana sul piatto
//
//  Assemblaggio:
//    - 4× viti M3×12 (FHCS o BHCS)
//    - 4× inserts M3 heat-set (opzionale, consigliato)
// ============================================================

/* ── VISUALIZZAZIONE ─────────────────────────────────────── */
mostra_front = true;
mostra_back  = true;
esploso      = 0;   // 0=assemblato | 28=vista esplosa

/* ── DISPLAY ILI9488 3.5" ───────────────────────────────── */
disp_pcb_w   = 108.04;
disp_pcb_h   =  61.74;
disp_pcb_t   =   2.2;   // Spessore PCB + componenti
disp_win_w   =  76.8;   // Apertura finestra schermo
disp_win_h   =  57.6;
disp_win_ox  =  15.6;   // Offset X finestra (da bordo sx PCB)
disp_win_oy  =   2.0;   // Offset Y finestra (da bordo inf PCB)
touch_extra  =   0.6;   // Margine extra vetro touch

/* ── ESP32-S3 DevKitC-1 ─────────────────────────────────── */
esp_w        =  69.0;
esp_h        =  26.0;
esp_t        =   1.6;
usb_w        =  10.5;   // Larghezza taglio USB-C
usb_h        =   5.0;   // Altezza taglio USB-C

/* ── GUSCIO ─────────────────────────────────────────────── */
wall         =   2.4;
corner_r     =   5.0;
margin       =   3.0;   // Margine intorno al display PCB
depth_front  =   6.5;
depth_back   =  19.0;
tol          =   0.25;  // Tolleranza stampa
screw_d      =   3.3;   // M3
boss_od      =   7.5;
boss_h       =   5.5;

/* ── MONTAGGIO A PARETE ─────────────────────────────────── */
wall_mount   = true;
kh_head      =   8.5;
kh_neck      =   4.2;

// ── Dimensioni esterne calcolate ──
OW = disp_pcb_w + (wall + margin) * 2;   // ~120.5 mm
OH = disp_pcb_h + (wall + margin) * 2;   // ~  73.7 mm

boss_xy = [
  [wall + boss_od/2 + 1,      wall + boss_od/2 + 1      ],
  [OW - wall - boss_od/2 - 1, wall + boss_od/2 + 1      ],
  [wall + boss_od/2 + 1,      OH - wall - boss_od/2 - 1 ],
  [OW - wall - boss_od/2 - 1, OH - wall - boss_od/2 - 1 ],
];

$fn = 72;

module rbox(w, h, d, r) {
  hull()
    for(x=[r, w-r]) for(y=[r, h-r])
      translate([x,y,0]) cylinder(r=r, h=d);
}

module rbox_shell(w, h, d, r, t) {
  difference() {
    rbox(w, h, d, r);
    translate([t, t, t]) rbox(w-2*t, h-2*t, d, max(0.01, r-t));
  }
}

// ============================================================
//  PARTE 1 — FRONT BEZEL
// ============================================================
module front_bezel() {
  difference() {
    union() {
      rbox_shell(OW, OH, depth_front, corner_r, wall);
      // Bordo rinforzato attorno al PCB display
      translate([wall+margin-1, wall+margin-1, wall])
        rbox_shell(disp_pcb_w+2, disp_pcb_h+2, depth_front-wall+1, 2, 1);
    }

    // Apertura schermo
    wx = wall + margin + disp_win_ox - touch_extra;
    wy = wall + margin + disp_win_oy - touch_extra;
    ww = disp_win_w + touch_extra*2;
    wh = disp_win_h + touch_extra*2;
    translate([wx, wy, -1]) rbox(ww, wh, depth_front+2, 1.5);

    // Tasca PCB display (posteriore)
    translate([wall+margin-tol, wall+margin-tol,
               depth_front - disp_pcb_t - 0.4])
      cube([disp_pcb_w+tol*2, disp_pcb_h+tol*2, disp_pcb_t+1]);

    // Fori viti
    for(p=boss_xy) translate([p[0],p[1],-1]) cylinder(d=screw_d, h=depth_front+2);

    // Canale cavi lato destro
    translate([OW-wall-1, OH/2-8, 0]) cube([wall+1.5, 16, 5.5]);
  }

  // Boss viti interni
  for(p=boss_xy)
    translate([p[0], p[1], depth_front-boss_h])
      difference() {
        cylinder(d=boss_od, h=boss_h);
        cylinder(d=screw_d, h=boss_h+1);
      }

  // Pin di allineamento
  translate([OW/2-22, wall*0.5, depth_front-3.5]) cylinder(d=2.0, h=3.5);
  translate([OW/2+22, wall*0.5, depth_front-3.5]) cylinder(d=2.0, h=3.5);
}

// ============================================================
//  PARTE 2 — BACK SHELL
// ============================================================
module back_shell() {
  esp_ox = (OW - esp_w) / 2;
  esp_oy = (OH - esp_h) / 2 + 4;

  difference() {
    union() {
      rbox_shell(OW, OH, depth_back, corner_r, wall);
      // Tray ESP32
      translate([esp_ox-wall*0.5, esp_oy-wall*0.5, wall])
        rbox_shell(esp_w+wall, esp_h+wall, 5.5, 2, wall*0.55);
      // Nervatura centrale
      translate([OW/2-1, wall, wall]) cube([2, OH-wall*2, depth_back-wall-3]);
    }

    // Fori viti passanti
    for(p=boss_xy) translate([p[0],p[1],-1]) cylinder(d=screw_d, h=depth_back+2);

    // Taglio USB-C (faccia anteriore)
    translate([OW/2-usb_w/2, -1, depth_back-usb_h-1.5])
      cube([usb_w, wall+2, usb_h+2]);

    // Slot GPIO / header (lato superiore)
    translate([wall+14, OH-wall-1, wall+2]) cube([OW-wall*2-28, wall+2, 9]);

    // Slot SWD laterale
    translate([-1, OH/2-6, wall+4]) cube([wall+2, 12, 6]);

    // Griglie ventilazione
    for(i=[0:4]) translate([wall+10+i*19, wall+8, depth_back-wall-1])
      rbox(11, OH-wall*2-16, wall+2, 2);

    // Fori pin allineamento
    translate([OW/2-22, wall*0.5-0.1, depth_back-4]) cylinder(d=2.5, h=5);
    translate([OW/2+22, wall*0.5-0.1, depth_back-4]) cylinder(d=2.5, h=5);

    // Keyhole montaggio a parete
    if(wall_mount)
      for(kx=[OW*0.28, OW*0.72]) {
        translate([kx, OH/2, depth_back-wall-1]) {
          cylinder(d=kh_head, h=wall+2);
          translate([-kh_neck/2, -kh_head, 0]) cube([kh_neck, kh_head, wall+2]);
        }
      }
  }

  // Standoff ESP32
  so = [[esp_ox+2.54,       esp_oy+2.54      ],
        [esp_ox+esp_w-2.54, esp_oy+2.54      ],
        [esp_ox+2.54,       esp_oy+esp_h-2.54],
        [esp_ox+esp_w-2.54, esp_oy+esp_h-2.54]];
  for(p=so) translate([p[0],p[1],wall])
    difference() { cylinder(d=5.0,h=4.5); cylinder(d=2.5,h=5); }

  // Boss viti
  for(p=boss_xy) translate([p[0],p[1],0])
    difference() {
      cylinder(d=boss_od, h=boss_h);
      cylinder(d=screw_d+0.2, h=boss_h+1);
    }
}

// ============================================================
//  RENDER ASSEMBLATO / ESPLOSO
// ============================================================
if(mostra_front)
  translate([0,0,esploso])
    color("#2B2D42", 0.95) front_bezel();

if(mostra_back)
  translate([0,0,-(depth_back+esploso)])
    mirror([0,0,1])
      color("#4A4E69", 0.88) back_shell();

// ============================================================
//  EXPORT STL — decommentare, poi File > Export > Export as STL
//
//  ► Front bezel:
//      front_bezel();
//
//  ► Back shell (piatto, spostato a fianco):
//      translate([OW+15, 0, 0]) back_shell();
// ============================================================
