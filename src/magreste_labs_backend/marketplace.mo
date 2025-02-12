//src/marketplace_canister/main.mo 
import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import Nat "mo:base/Time";
import NFT "mo:base/NFT" ; //reemplaza con el ID de tu canister de NFT
import Auth "mo:base/Auth";



actor MarketplaceNFT {
   type listing = {
        nftId: Nat; //ID DEL NFT LISTADO
        seller:Principal;  //PORPIETARIO QUE VENDE EL NFT
        price: Nat; //PRECIO DEL NFT EN MONEDAS

   };

     stable var listing: [Listing] = [];//lista de Nfts en venta
     

     //funcion para listar un NFT para la venta

     public func listNFT(nftId: Nat, price:  Nat) : Text {

        //metodo para verificar si el nft existe se supone que lo tengo ese metodo

        let nftOpt = NFT.getNFT(nftId);//obtener el Nft de tu canister

         switch (nftOpt)  {
            case (null){ return "NFT not exit";}

            case (nft) {

                if (nft.owner ! = msg.caller) {

                    if (nft.owner != msg. caller){
                        return " no eres el propietariode este NFT"; //verificar la propiedad
                    }
                
                let listing = Listing {
                    nftId = nftId;
                    seller = msg.caller;
                    price = price;
                };
                listing : = listing # [listing]; // adicionar el listado
                Debug.print ("NFT listado:" # Nat.toText (nftId # " por" # Nat.toText (price) # "monedas"));
                return "NFT listed successfully";
            };
        };
    }

       //funcion para comprar un NFT

     public func buyNFT (nftId: Nat) : Text {
          let optListing = Array.fin <Listing > (fun (listing){listing.nftId ==n nftId},listings);
           switch (optListing){
           case (null) { return "NFT not disponible para la compra";}

           case (listing){// se asume que s ehizo la trasferencia con exito
           // trasferir el nft al nuevo propietario
           NFT.transferNFT (listing.nftId, msg.caller);// trasferir ala direccion del comprador
           
           listings ;= Array.remove<listing> (listing, listings); //eliminar la listing
           Debug.print ("NFT comprado: " # Nat.toText(nftId # " por" # Principal.toText (msg.caller)));
           return "compra exitosa";
           
           };
        };
     }

     //funcion para retirar un NFT del listado

     public func unlistNFT (nftId: Nat) Text {
        let optListing = Array.fin <Listing> (fun (listing) {
            listing.nftId == nftId}, listings);

        switch(optListin) {
            case(null) { return "NFT no esta listado" ;}

            case(listing) { 
                if (listing.seller != msg.caller){
                    return "No eres el vendedor de este NFT"; // verifica que solo el vendedor puede retirar
                }
            listings:= Array.REMOVE<Listing> (listing, listings); //elimina d ela lista
            return "NFT retirado d ela lista con exito";
        };
     };
   }
}


                   








       
        
     




             
    

        