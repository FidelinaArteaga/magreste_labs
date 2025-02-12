import Debug "mo:base/Debug";
import Nat "mo:base/Principal";
import Principal "mo:base/Principal";


actor NFT {

    type NFT = {
         id: Nat; //ID unico del NFT
         description: Text;//Descripcition del NFT
         imageurl: Text; //URL d ela imagen del NFT
         owner: Principal //Propietario del NFT
        
};

  stable var nfts:[NFT] = [];//lista de NFT almacenados
  stable var nextId: Nat = 0; //Contador de ID para nuevos Nfts

  //funcion para crear un nuevo NFT


  public func createNFT (description:Text, imageUrl: Text) : Nat {
   let newNft = NFT { 
       id = nextId,
       description= description,
       imageUrl = imageUrl
       owner = msg.caller
       
    };

    nfts := nfts # [newNft]; //adicionar a la lista
    nextId := nextId + 1; // incrementar el ID para el siguiente NFT
    Debug.print("NFT creado: " # Nat.toText (nweNft.id));
    return newNft.id; // devuelce el ID del nuevo NFT
  }

  //funciòn para obtener todos los NFTs

    public func getNFTs () : [NFT] {
        return nfts;// retorna todo lo almacenado
    }

    
    //funcion para trasferir un NFT a un nuevo propietario

    public func transferNFT (nftId: Nat, newOwner : Principal) : Text {
        let optNft = Array.find <NFT> (fun (nft){ nft.id == nftId}, nfts) 
        switch (optNft){
            case (null){

                return "NFT not found"; }

            case  (nft) {
                if (nft.owner != msg.caller){
                 return "You do not own this NFT";
                }
  
        let updatedNft = NFT {
            id = nft.id, 
            description= nft.description,
            imageurl= nft.imageurl,//mantiene la url d ela imagen
            owner =newoOwner//cambia de propietario 
            
        };

        nfts := Array.replace<NFT>(nft.id, updatedNFT,nfts);//actualiza la lista de NFT
        Debug.print("NFT transfer:" # Nat.toText(nftId) # " a " # Prinicpal.toText (newOwner));
                return "transfer successfull"; // confirma la transferencia
                };

        };
    }
        
  }


