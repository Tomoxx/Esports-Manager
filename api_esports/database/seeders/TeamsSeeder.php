<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TeamsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('teams')->insert([
            ['name' => 'w7m esports', 'game' => 'Rocket League', 'region' => 'South America'],
            ['name' => 'Erased', 'game' => 'Rocket League', 'region' => 'South America'],
            ['name' => 'G2 Stride', 'game' => 'Rocket League', 'region' => 'North America'],
            ['name' => 'Team Vitality', 'game' => 'Rocket League', 'region' => 'Europe'],
            ['name' => 'FURIA Esports', 'game' => 'Rocket League', 'region' => 'South America'],
            ['name' => 'KRÜ Esports', 'game' => 'Rocket League', 'region' => 'South America'],
            ['name' => 'KRÜ Esports', 'game' => 'Valorant', 'region' => 'South America'],
            ['name' => 'Gen G', 'game' => 'Valorant', 'region' => 'Asia'],
            ['name' => 'Fnatic', 'game' => 'Valorant', 'region' => 'Europe'],
        ]);
    }
}
