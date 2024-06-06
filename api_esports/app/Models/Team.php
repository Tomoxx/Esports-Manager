<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Team extends Model
{
    use HasFactory;
    protected $table = 'teams';

    protected $appends = ['cantidad'];

    //relacion con players
    public function players(): HasMany
    {
        return $this->hasMany(Player::class);
    }

    //asignar valor a cantidad
    public function getCantidadAttribute()
    {
        return count($this->players);
    }
}
