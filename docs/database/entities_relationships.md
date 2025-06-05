<!-- database\entities_relationships.md -->

Voici les relations impliquées par les contraintes de clé étrangère (et les associations prévues) dans le schéma :

1. **User ⇄ Address**

   * **Un utilisateur peut avoir plusieurs adresses.**

     * Chaque enregistrement dans la table _Address_ a une clé étrangère `user_id` pointant vers la table _User_. Un seul utilisateur peut donc apparaître dans plusieurs enregistrements d'adresse.

   * **Une adresse appartient à un seul utilisateur.**

     * Le champ `user_id` dans la table _Address_ fait référence à un seul utilisateur.

2. **Seller → User**

   * **Le role `seller` peut être associé à plusieurs utilisateurs.**

     * L'utilisateur dispose d'une clé étrangère `seller_id` pouvant être _null_ et faisant référence au vendeur ; plusieurs utilisateurs peuvent partager le même `seller_id`.

   * **Un utilisateur peut être un vendeur. (facultatif)**

     * Si le champ `User.seller_id` n'est pas _null_, il pointe vers la table _Seller_.

3. **User → Review**

   * **Un utilisateur peut rédiger plusieurs avis.**

     * Chaque enregistrement dans la table _Review_ dispose d'une clé étrangère `user_id` pointant vers la table _User_.

   * **Un avis appartient à un seul utilisateur.**

     * Le champ `Review.user_id` identifie l'utilisateur qui l'a publié.

4. **User → Order**

   * **Un utilisateur peut passer plusieurs commandes.**

     * Chaque enregistrement dans la table _Order_ comporte une clé étrangère `user_id` pointant vers la table _User_.

   * **Une commande appartient à un seul utilisateur.**

     * Le champ `Order.user_id` indique quel utilisateur a passé cette commande.

5. **Order → OrderItem**

   * **Une commande peut contenir plusieurs articles.**

     * Chaque enregistrement dans la table _OrderItem_ comporte une clé étrangère `order_id` pointant vers la table _Order_.

   * **Un article appartient à une seule commande.**

     * Le champ `OrderItem.order_id` le relie à sa commande parent.

6. **Product → OrderItem**

   * **Un produit peut apparaître dans plusieurs articles.**

     * Chaque enregistrement dans la table _OrderItem_ comporte une clé étrangère `product_id` pointant vers la table _Product_.

   * **Un article fait référence à un seul produit.**

     * Le champ `OrderItem.product_id` indique quel produit a été commandé.

7. **Order → Shipment**

   * **Une commande peut avoir plusieurs expéditions.**

     * Chaque enregistrement dans la table _Shipment_ comporte une clé étrangère `order_id` pointant vers la table _Order_.

   * **Une expédition appartient à une seule commande.**

     * Le champ `Shipment.order_id` indique quelle commande est expédiée.

8. **Order → Payment**

   * **Une commande peut avoir plusieurs paiements.**

     * Chaque enregistrement dans la table _Payment_ comporte une clé étrangère `order_id` pointant vers la table _Order_.

   * **Un paiement appartient à une seule commande.**

     * Le champ `Payment.order_id` relie ce paiement à sa commande.

9. **User → ShoppingCart**

   * **Un utilisateur peut avoir plusieurs paniers.**

     * Chaque enregistrement dans la table _ShoppingCart_ a une clé étrangère `user_id` pointant vers la table _User_.

   * **Un panier appartient à un seul utilisateur.**

     * Le champ `ShoppingCart.user_id` indique à qui appartient le panier.

10. **ShoppingCart → CartItem**

    * **Un panier peut contenir plusieurs items.**

      * Chaque enregistrement dans la table _CartItem_ possède une clé étrangère `shopping_cart_id` pointant vers la table _ShoppingCart_.

    * **Un item appartient à un seul panier.**

      * Le champ `CartItem.shopping_cart_id` le relie à ce panier.

11. **Product → CartItem**

    * **Un produit peut apparaître dans plusieurs items.**

      * Chaque enregistrement dans la table _CartItem_ possède une clé étrangère `product_id` pointant vers la table _Product_.

    * **Un item fait référence à un seul produit.**

      * Le champ `CartItem.product_id` spécifie quel produit se trouve dans le panier.

12. **Product ↔ Category (via `Product_Category`)**

    * **Many‐to‐Many:**

      * **Un produit peut appartenir à plusieurs catégories.**

        * `Product_Category` a un clé étrangère `product_id` pointant vers _Product_.
      * **Une catégorie peut inclure plusieurs produits.**

        * `Product_Category` a un clé étrangère `category_id` pointant vers _Category_.
    * **Une ligne `Product_Category` relie exactement un produit à exactement une catégorie.**

13. **User → UserSession**

    * **Un utilisateur peut avoir plusieurs sessions utilisateur.**

      * Chaque ligne _UserSession_ comporte une clé étrangère `user_id` pointant vers _User_.
    * **Une session utilisateur appartient à exactement un utilisateur.**

      * `UserSession.user_id` indique quel utilisateur est propriétaire de cette session.

14. **User → Like**

    * **Un utilisateur peut aimer plusieurs produits.**

      * Chaque ligne _Like_ a une clé étrangère `user_id` pointant vers _User_.
    * **Un Like appartient à exactement un User.**

      * `Like.user_id` identifie qui a aimé quelque chose.

15. **Product → Like**

    * **Un produit peut être aimé par plusieurs utilisateurs.**

      * Chaque ligne _Like_ a une clé étrangère `product_id` pointant vers _Product_.
    * **Un Like fait référence à exactement un produit.**

      * `Like.product_id` indique quel produit a été aimé.

---

Pour résumer, dans le style “Entity A → Entity B” (One‐to‐Many):

* **User → Address** (1 user : *many* addresses)
* **Seller → User** (1 seller : *many* users)
* **User → Review** (1 user : *many* reviews)
* **User → Order** (1 user : *many* orders)
* **Order → OrderItem** (1 order : *many* order\_items)
* **Product → OrderItem** (1 product : *many* order\_items)
* **Order → Shipment** (1 order : *many* shipments)
* **Order → Payment** (1 order : *many* payments)
* **User → ShoppingCart** (1 user : *many* shopping\_carts)
* **ShoppingCart → CartItem** (1 cart : *many* cart\_items)
* **Product → CartItem** (1 product : *many* cart\_items)
* **Product ↔ Category** (many‐to‐many via Product\_Category)
* **User → UserSession** (1 user : *many* user\_sessions)
* **User → Like** (1 user : *many* likes)
* **Product → Like** (1 product : *many* likes)

Et les tables de liaison :

* **Product\_Category**: chaque ligne relie exactement un produit à une seule catégorie (implémentant la relation many‐to‐many).
