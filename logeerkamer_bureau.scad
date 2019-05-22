//kamer
kamer = [1920,1580,2460];
muur_dikte = 200;
plint_h = 100;
plint_d = 10;

// allerlei
mdf_dikte = 18;
ooghoogte = 1270;
armafstand = 400;

// toetsenbord + muis
toetsenbord = [460,160,30];
muis = [70,100,35];

// schermen
scherm_p = [830,40,429];

// synthesizer
synth = [367,1024,119];
synth_marge_kabels = 130;
synth_h = 650;

// midi controller
midi = [940,270,90];

// werkblad
werkblad = [1920,800,40];
werkhoogte = 760;

//3D printer
3D_printer = [450,600,450];

//schabben hoog
plint_plafond_hoogte = 60;
stripboek_hoogte = 315;
stripboek_hoogte_marge = 20;
stripboek_diepte = 225;
stripboek_diepte_marge = 20;
boek_hoogte = 250;
boek_diepte = 170;
boek_hoogte_marge = 20;
boek_diepte_marge = 20;
klein_boek_hoogte = 180;
klein_boek_hoogte_marge = 0;
cd_hoogte = 125;
cd_diepte = 142;
cd_marge_h = 15;
cd_marge_d = 5;

smaller_factor = 0.8;
foto_plank_diepte = 50;




// de kamer zelf
color([.2,.2,.2,.5]) {
    translate([-muur_dikte,0,0]){
        cube([muur_dikte,kamer.y,kamer.z]);
    }
    translate([-muur_dikte,-muur_dikte,0]){
        cube([kamer.x+muur_dikte,muur_dikte,kamer.z]);
    }
    translate([-muur_dikte,-muur_dikte,-muur_dikte]){
        cube([kamer.x+muur_dikte,kamer.y+muur_dikte,muur_dikte]);
    }
    translate([-0,-0,-0]){
        cube([kamer.x,plint_d,plint_h]);
    }
    translate([-0,-0,-0]){
        cube([plint_d,kamer.y,plint_h]);
    }
}

// primair scherm
{
    translate([werkblad.x/2 - scherm_p.x/2, werkblad.y - scherm_p.y - armafstand, ooghoogte -scherm_p.z]){
        # cube(scherm_p);
    }
}

// synth
/*
{ 
    translate([synth_marge_kabels,kamer.y - synth.y, synth_h]){
        # cube(synth);
    }
}
*/

// toetsenbord + muis
{
    translate([0,0,werkhoogte]){
       translate([  werkblad.x/2-toetsenbord.x/2,
                    werkblad.y-toetsenbord.y-250,
                    0]){
            # cube(toetsenbord);
            translate([-150,40,0]){
                # cube(muis);
            }
        }
    }
}

// midi
{
    translate([ werkblad.x/2-midi.x/2,werkblad.y-midi.y,werkhoogte-werkblad.z-midi.z]){
        # cube(midi);
    }
}

//werkblad
{
    translate([0,0,werkhoogte-werkblad.z]){
        cube([werkblad.x, werkblad.y, werkblad.z]);
    }
}


// cd rek
translate([0,kamer.y - 1100,kamer.z-1000]) {
    rotate([-45,0,0]){
        teken_cd_rek();
    }
}

//wandkasten -> stripboeken
translate([0,0,kamer.z]){
    teken_wand_kast();
}

//wandkast -> boekenrek
translate([0,0,kamer.z - (plint_plafond_hoogte + 2*mdf_dikte + stripboek_hoogte + stripboek_hoogte_marge) - mdf_dikte]){
    teken_boekenkast();
}

//fotoplankje
translate([0,0,werkhoogte+550]){
    teken_foto_plank();
}

// printer kast
translate([3D_printer.y+2*mdf_dikte,0,plint_h]){
    rotate([0,0,90]){
        teken_printer_kast();
    }
}
    

module teken_cd_rek() {
    n_hoeken = 3; // aantal hoekvormige modules in het rek
    cdvak = [cd_diepte + cd_marge_d,cd_hoogte + cd_marge_h,cd_hoogte + cd_marge_h];
    
    // kast bestaat uit hoekvormige modules en een afsluitend hoekje
    for(i=[0:n_hoeken-1]){
        teken_hoek_module(i);
    }
    //afsluitend hoekje
    teken_afsluitend_hoekje(n_hoeken);
    
    /*
    * lijn trekken om de maximale breedte te zien
    */
    //teken_max_breedte(1000);
    
    /*
    * cd blokken tekenen om te zien of alles past
    */
    //teken_cds();
    
    /*
    * helperfunties en -modules
    */
    module teken_hoek_module(n) {
        l4 = 4*cdvak.y + 2*mdf_dikte;   // lengte plank van 4 eenheden
        l5 = 5*cdvak.y + 2*mdf_dikte;   // lengte plank van 5 eenheden
        l1 = cdvak.y;                   // inliggend plankje van 1 eenheid
        
        translate([0,n*(mdf_dikte+cdvak.y),n*(mdf_dikte+cdvak.z)]) {
            {
                if (n==0) {
                    cube([cdvak.x,l4,mdf_dikte]);
                } else {
                    translate([0,-cdvak.y,0]) {
                        cube([cdvak.x,l5,mdf_dikte]);
                    }
                }
            }
            
            translate([0,0,mdf_dikte]) {
                cube([cdvak.x,mdf_dikte,l4]);
            }
            
            translate([0,mdf_dikte,l4]) {
                cube([cdvak.x,l1,mdf_dikte]);
            }
            
            translate([0,l4-mdf_dikte,mdf_dikte]) {
                cube([cdvak.x,mdf_dikte,l1]);
            }
        }
        
    }
    
    module teken_afsluitend_hoekje(n_hoeken) {

        translate([ 0,
                    (n_hoeken-1) * cdvak.y + n_hoeken * mdf_dikte,
                    n_hoeken * mdf_dikte + n_hoeken * cdvak.z]) 
        {
            l = 4*cdvak.y + mdf_dikte;
            cube([cdvak.x,l,mdf_dikte]);
        }
        
        translate([ 0,
                    n_hoeken * cdvak.y + n_hoeken * mdf_dikte,
                    (n_hoeken+1) * mdf_dikte + n_hoeken * cdvak.z]) 
        {
            l = 3*cdvak.y + mdf_dikte;
            cube([cdvak.x,mdf_dikte,l]);
        }
        
        translate([ 0,
                    n_hoeken * cdvak.y + (n_hoeken+1) * mdf_dikte,
                    (n_hoeken+1) * (mdf_dikte + cdvak.z)]) 
        {
            l = cdvak.y + mdf_dikte;
            cube([cdvak.x,l,mdf_dikte]);
        }
        
        translate([ 0,
                    (n_hoeken+1) * (cdvak.y + mdf_dikte),
                    (n_hoeken+1) * mdf_dikte + n_hoeken * cdvak.z]) 
        {
            l = cdvak.y;
            cube([cdvak.x,mdf_dikte,l]);
        }

    }
    
    
    module teken_max_breedte(max_l) {
        rotate([45,0,0]){
            translate([-5,0,0]){
                color([0,1,1,1]) cube([10,max_l,10]);
            }
        }
    }
    
    module teken_cds() {
        n_rijen = 3; // aantal "vakken" dat het cd rek heeft
        cd_kleur = [.91,.48,.81,.6];
        
        function offset_y(kolom) = mdf_dikte + kolom * (cdvak.y+mdf_dikte);
        function offset_z(rij) = mdf_dikte + rij * (cdvak.z+mdf_dikte);

        // rijen opvullen
        for(j=[0:n_rijen - 1]) {
            for(i=[0:n_rijen]) {
                translate([ 0,
                            offset_y(j) + i*cdvak.y,
                            offset_z(j) ])
                {
                    color(cd_kleur) cube(cdvak);
                }
            }
        }
        
        // kolommen opvullen
        for(j=[0:n_rijen-1]) {
            translate([0,0,offset_z(j)]) {
                for(i=[1:n_rijen]){
                    translate([0,offset_y(j),mdf_dikte+i*cdvak.z]) {
                        color(cd_kleur) cube(cdvak);
                    }
                }
            }
        }
        
        // laatste vakje opvullen
        translate([
            0,
            mdf_dikte + n_rijen * (mdf_dikte + cdvak.y),
            mdf_dikte + n_rijen * (mdf_dikte + cdvak.z)]) 
        { 
                    color(cd_kleur) cube(cdvak); 
        }
    }
}

module teken_wand_kast() {
    //teken_boeken();
    //van boven naar beneden: plint - strips - boeken - boeken - boeken
    teken_plint();
    teken_strip_module(1);
    
    
    module teken_plint(){
        x = 0;
        y = stripboek_diepte + stripboek_diepte_marge - mdf_dikte;
        z = -plint_plafond_hoogte;
        
        //voorkant
        translate([x,y+mdf_dikte,z]){
            cube([kamer.x, mdf_dikte,plint_plafond_hoogte]);
        }
        
        //zijkant
        translate([kamer.x-mdf_dikte,0,z]){
            cube([mdf_dikte, y+mdf_dikte,plint_plafond_hoogte]);
        }
    }
    
    module teken_strip_module(vakken) {
        h = stripboek_hoogte + stripboek_hoogte_marge;
        b = kamer.x;
        d = stripboek_diepte + stripboek_diepte_marge;
        
        //achterwand
        translate([mdf_dikte,0,-plint_plafond_hoogte-h-mdf_dikte]){
            cube([b-2*mdf_dikte,mdf_dikte,h]);
        }
        
        //onderste plank
        translate([0,0,-plint_plafond_hoogte-h-2*mdf_dikte]){
            cube([b,d+mdf_dikte,mdf_dikte]);
        }
        
        //bovenste plank
        translate([0,0,-plint_plafond_hoogte-mdf_dikte]){
            cube([b,d+mdf_dikte,mdf_dikte]);
        }
        
        //zijkanten
        translate([0,0,-plint_plafond_hoogte-h-mdf_dikte]){
            cube([mdf_dikte,d+mdf_dikte,h]);
        }
        translate([kamer.x-mdf_dikte,0,-plint_plafond_hoogte-h-mdf_dikte]){
            cube([mdf_dikte,d+mdf_dikte,h]);
        }
    }
    
    module teken_boeken(){
        h = stripboek_hoogte + stripboek_hoogte_marge;
        b = kamer.x;
        d = stripboek_diepte + stripboek_diepte_marge;
        translate([0,mdf_dikte,-plint_plafond_hoogte-h-mdf_dikte]){
            #cube([b,d,h]);
        }
    }
}

module teken_boekenkast(){
    h = boek_hoogte + boek_hoogte_marge;
    b = kamer.x * smaller_factor;
    d = boek_diepte + boek_diepte_marge;
    
    x = kamer.x/2-b/2;
    
    //eerste rij boeken
    translate([x,mdf_dikte,-h]){
        //#cube([b,d,h]);
    }
    //tweede rij boeken
    translate([x,mdf_dikte,-(2*h + mdf_dikte)]){
        //#cube([b,d,h]);
    }
    
    //achterwand
    translate([x,0,-(2*h+mdf_dikte)]){
        cube([b,mdf_dikte,2*h+mdf_dikte]);
    }
    
    //bovenste plank
    translate([x,0,0]){
        cube([b,d+mdf_dikte,mdf_dikte]);
    }
    
    //middelste plank
    translate([x,mdf_dikte,-(h+mdf_dikte)]){
        cube([b,d,mdf_dikte]);
    }
    
    //onderste plank
    translate([x,0,-2*(h+mdf_dikte)]){
        cube([b,d+mdf_dikte,mdf_dikte]);
    }
    
    //linkerkant
    translate([x-mdf_dikte,0,-2*(h+mdf_dikte)]){
        cube([mdf_dikte,d+mdf_dikte,3*mdf_dikte + 2*h]);
    }
    
    //rechterkant
    translate([x+b,0,-2*(h+mdf_dikte)]){
        cube([mdf_dikte,d+mdf_dikte,3*mdf_dikte + 2*h]);
    }
}

module teken_foto_plank(){    
    h = mdf_dikte;
    b = kamer.x * smaller_factor;
    d = foto_plank_diepte;
    
    x = kamer.x/2-b/2;
    difference(){
        //plankje
        translate([x,0,-2*(h+mdf_dikte)]){
            cube([b,d,h]);
        }
        
        //goot frezen
        translate([x,foto_plank_diepte - 10 ,-2*(h+mdf_dikte)+(mdf_dikte - 5)]){
            cube([b,5,5]);
        }
    }
}

module teken_printer_kast(){
    // 3D printer
    translate([mdf_dikte,mdf_dikte,mdf_dikte]){
            color("blue",.5) cube(3D_printer);
    }
    //onder
    translate([0,0,0]){
        cube([3D_printer.x + 2*mdf_dikte,3D_printer.y + 2*mdf_dikte, mdf_dikte]);
    }
    //boven
    translate([0,0,3D_printer.z+mdf_dikte]){
        cube([3D_printer.x + 2*mdf_dikte,3D_printer.y + 2*mdf_dikte, mdf_dikte]);
    }
    //links (deur)
    translate([3D_printer.x+mdf_dikte,3D_printer.y,mdf_dikte]){
        rotate(a=60, v=[0,0,1]){
            translate([0,-3D_printer.y,0]){
                cube([mdf_dikte,3D_printer.y, 3D_printer.z]);
            }
        }
    }
    //rechts
    translate([0,mdf_dikte,mdf_dikte]){
        cube([mdf_dikte,3D_printer.y, 3D_printer.z]);
    }
    //achter
    translate([0,0,mdf_dikte]){
        cube([3D_printer.x + 2*mdf_dikte,mdf_dikte, 3D_printer.z]);
    }
    //voor
    translate([0,3D_printer.y+mdf_dikte,mdf_dikte]){
        cube([3D_printer.x + 2*mdf_dikte,mdf_dikte, 3D_printer.z]);
    }
}


