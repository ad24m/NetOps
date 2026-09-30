# Expériences O3 — Grafana

## 1. Test de panne

### Prédiction écrite avant la mesure — 30/09/2026

Je vais couper temporairement le lien Ethernet1 de pe-paris vers p1.
La topologie possède un second lien entre pe-paris et p2. Je prévois donc
qu’après une courte reconvergence OSPF/LDP, le trafic vers Avignon pourra
passer par p2. Un ping de host-paris-a vers 10.10.2.10 peut perdre quelques
paquets pendant la reconvergence, puis doit reprendre. La session VPNv4 de
pe-paris vers p1 devrait rester établie si la route de secours fonctionne.
Le trafic devrait quitter Ethernet1 et passer par Ethernet2 sur pe-paris.


### Mesure — 30/09/2026

- Avant la coupure, la route vers 10.10.2.0/24 utilisait Ethernet1 et Ethernet2.
- Ethernet1 de pe-paris a été coupée. La route est restée présente par Ethernet2.
- Pendant la coupure, la session VPNv4 vers 10.255.0.11 et la session eBGP
  vers 10.1.0.2 sont restées Established.
- Après le rétablissement d’Ethernet1, les deux chemins sont revenus.
- Le basculement a été mesuré avec la table de routage et les sessions BGP ; le bilan statistique du ping continu n’a pas été conservé.

## 2. Test de chemin

### Méthode

Depuis host-paris-a, tester le chemin vers 10.10.2.10 dans TENANT_1.
Comparer le chemin observé avec la route VPN présente sur pe-paris.

### Résultat

Le traceroute de host-paris-a vers 10.10.2.10 atteint la destination au
saut 5. Les sauts observés sont 10.10.1.1, puis 10.1.0.1 ; les sauts 3 et 4
ne répondent pas aux sondes traceroute. La destination répond, donc le chemin
aboutit. La route de pe-paris montre les deux chemins MPLS disponibles.
